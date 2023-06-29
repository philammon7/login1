//
//  RegisterViewController.swift
//  login1
//
//  Created by 탁영웅 on 2023/07/02.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Prooerties
    
    var isValidEmail = false {
        didSet {// 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidName = false {
        didSet {// 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet {// 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet {// 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    //Textfields
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var nicknameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var textFields: [UITextField] {
        [emailTextfield, nameTextfield, nicknameTextfield, passwordTextfield]
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        
    }
    //MARK: - Actions
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField){
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextfield:
            self.isValidEmail = text.isValidEmail()
            
        case nameTextfield:
            self.isValidName = text.count > 2
        case nicknameTextfield:
            self.isValidNickname = text.count > 2
        case passwordTextfield:
            self.isValidPassword = text.isValidPassword()
        default:
            fatalError("Missing TextField...")
        }
    }
    
    
    //MARK: - Helpers
    private func setupTextField(){
        textFields.forEach{ tf in
            tf.addTarget(self,
                         action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
        
        
    }
    // 사용자가 입력한 회원정보를 확인하고 -> UI 업데이트
    
    private func validateUserInfo() {
        
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {
             
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33){ self.signupButton.backgroundColor = UIColor.facebookColor
            }
        } else {
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33){
                self.signupButton.backgroundColor = .disabledButtonColor
            }
        }
    }
    
}


extension String {
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z](?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-z0-9a-z._%+-]+@[A-za-z0-9.-]+\\.[A-za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
