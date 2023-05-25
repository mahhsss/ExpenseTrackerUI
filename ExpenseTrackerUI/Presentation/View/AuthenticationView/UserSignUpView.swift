//
//  UserSignUpView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class UserSignUpPageView: NSView {
    
    var nameTextField = NSTextField()
    var emailIdTextField = NSTextField()
    var passwordTextField = NSSecureTextField()
    var repasswordTextField = NSSecureTextField()
    var signupStack: NSStackView!
    var signupButton = NSButton()
    var loginLabel = NSTextField()
    var presenter: UserSignUpPagePresenterContract
    var user: User?
    
    init(presenter: AddNewUserPresenter) {
        
        self.presenter = presenter
        super.init(frame: NSZeroRect)
        configureSignUpForm()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserSignUpPageView: AddNewUserViewContract {
    
    func configureSignUpForm() {
        
        let signupLabel = CustomText.customStringLabel(label: "SignUp", fontSize: 40)
        let nameLable = CustomText.customStringLabel(label: "Name", fontSize: 15)
        let emailLable = CustomText.customStringLabel(label: "EmailId", fontSize: 15)
        let password1 = CustomText.customStringLabel(label: "Password", fontSize: 15)
        let password2 = CustomText.customStringLabel(label: "Re-enter Password", fontSize: 15)
        let nameTextBox = customTextBox(textField: nameTextField, name: "name")
        let emailIdTextBox = customTextBox(textField: emailIdTextField, name: "EmailId")
        let password1TextBox = customPasswordTextBox()
        let password2TextBox = customPasswordTextBox()
        let string = "Already have an account!  Login"
        let attributedString = NSMutableAttributedString(string: string)
        
        
        signupButton = customSignupButton(loginButton: signupButton)
        signupStack = NSStackView(views: [nameLable, nameTextBox, emailLable, emailIdTextBox, password1, password1TextBox, password2, password2TextBox])
        signupStack.spacing = 15
        signupStack.orientation = .vertical
        signupStack.alignment = .left
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 26, length: 5))
        loginLabel = CustomText.customStringLabel(label: string, fontSize: 15)
        loginLabel.attributedStringValue = attributedString
        
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        signupStack.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(signupLabel)
        addSubview(signupStack)
        addSubview(signupButton)
        addSubview(loginLabel)
        
        
        
        NSLayoutConstraint.activate([
            signupLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signupLabel.bottomAnchor.constraint(equalTo: signupStack.topAnchor, constant: -30),
            signupStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            signupStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            signupButton.centerYAnchor.constraint(equalTo: signupStack.bottomAnchor, constant: 50),
            signupButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 40)
        ])
        
    }
    
    func customTextBox(textField: NSTextField, name: String) -> NSBox {
        
        let borderBox = NSBox()
        borderBox.boxType = .custom
        textField.placeholderString = "Enter Your \(name)"
        textField.translatesAutoresizingMaskIntoConstraints =  false
        textField.isEditable = true
        textField.wantsLayer = true
        textField.isSelectable = true
        textField.isBordered = false
        textField.focusRingType = .none
        textField.usesSingleLineMode = true
        textField.font = .systemFont(ofSize: 20)
        textField.wantsLayer = true
        textField.backgroundColor = .none
        borderBox.contentView = textField
        borderBox.wantsLayer = true
        borderBox.layer?.cornerRadius = 10
        borderBox.borderWidth = 0
        borderBox.layer?.backgroundColor = .black
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            borderBox.widthAnchor.constraint(equalToConstant: 450),
            borderBox.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        return borderBox
    }
    
    func customPasswordTextBox() -> NSBox {
        
        let borderBox = NSBox()
        passwordTextField = NSSecureTextField()
        borderBox.boxType = .custom
        passwordTextField.placeholderString = "Enter the Password"
        passwordTextField.translatesAutoresizingMaskIntoConstraints =  false
        passwordTextField.isEditable = true
        passwordTextField.wantsLayer = true
        passwordTextField.isSelectable = true
        passwordTextField.isBordered = false
        passwordTextField.focusRingType = .none
        passwordTextField.usesSingleLineMode = true
        passwordTextField.font = .systemFont(ofSize: 20)
        passwordTextField.wantsLayer = true
        passwordTextField.backgroundColor = .none
        borderBox.contentView = passwordTextField
        borderBox.wantsLayer = true
        borderBox.layer?.cornerRadius = 10
        borderBox.borderWidth = 0
        borderBox.layer?.backgroundColor = .black
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            borderBox.widthAnchor.constraint(equalToConstant: 450),
            borderBox.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        return borderBox
    }
    
    func customSignupButton(loginButton: NSButton) -> NSButton {
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.wantsLayer = true
        loginButton.title = "Signup"
//        loginButton.layer?.backgroundColor = #colorLiteral(red: 0.3159786165, green: 0.8165252209, blue: 1, alpha: 1)
        loginButton.contentTintColor = .white
        loginButton.isBordered = false
        loginButton.alignment = .center
        loginButton.target = self
        loginButton.action = #selector(authenticateUser(_:))
        loginButton.focusRingType = .none
        loginButton.font = .systemFont(ofSize: 17)
        loginButton.layer?.borderWidth = 2
        loginButton.layer?.borderColor = .white
        
        loginButton.layer?.cornerRadius = 20
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalToConstant: 145),
        ])
        return loginButton
    }
    
    @objc func authenticateUser(_ sender: NSButton) {
        
        user = User(userId: 0, name: nameTextField.stringValue, emailId: emailIdTextField.stringValue, password: passwordTextField.stringValue)
        presenter.viewLoad(user: user!)
    }
    
    func load(sucess: AddnewUserResponse) {
        print("\n\(sucess.message)\n")
        
        
    }
    
    func failure(error: AddNewUserError) {
        print("\n\(error.error)\n")
    }
}

