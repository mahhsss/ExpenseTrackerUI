//
//  UserLoginView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 01/03/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class UserLoginPageView: NSView {
    
    var emailTextField = NSTextField()
    var passwordTextField = NSSecureTextField()
    var loginButton = NSButton()
    var signUpLabel = NSTextField()
    var loginStack = NSStackView()
    var presenter: UserLoginPresenterContract
    var errorString: NSTextField!
    
    init(presenter: UserLoginPresenterContract) {
        
        self.presenter = presenter
        super.init(frame: NSRect())
        configureLoginForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserLoginPageView {
    
    func userLogin() {
        print("\nEnter EmailId")
        let emailId = readLine()!
        print("\nPassword")
        let password = readLine()!
        presenter.viewDidLoad(emailId: emailId, password: password)
    }
    
    func configureLoginForm() {
        
        let loginLabel = CustomText.customStringLabel(label: "Login", fontSize: 47)
        let emailLabel = CustomText.customStringLabel(label: "EmailId", fontSize: 16)
        let passwordLabel = CustomText.customStringLabel(label: "Password", fontSize: 16)
        let emailTextBox = customTextBox(textField: emailTextField, name: "EmailId")
        let passwordTextBox = customPasswordTextBox()
        let string = "Don't have an account?  SignUp"
        let attributedString = NSMutableAttributedString(string: string)
        errorString = CustomText.customStringLabel(label: "Invalid Credentials", fontSize: 15, fontColor: .red)
        
        errorString.isHidden = true
        loginButton = customLoginButton(loginButton: loginButton)
        loginStack = NSStackView(views: [emailLabel, emailTextBox, passwordLabel, passwordTextBox, errorString])
        loginStack.spacing = 20
        loginStack.orientation = .vertical
        loginStack.alignment = .left
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 24, length: 6))
        signUpLabel = CustomText.customStringLabel(label: string, fontSize: 15)
        signUpLabel.attributedStringValue = attributedString
        
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        addSubview(loginLabel)
        addSubview(loginStack)
        addSubview(loginButton)
        addSubview(signUpLabel)
        
        
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: loginStack.topAnchor, constant: -50),
            loginStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: 80),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpLabel.centerYAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 60)
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
        borderBox.layer?.backgroundColor = CustomText.boxColor().cgColor
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
        borderBox.layer?.backgroundColor = CustomText.boxColor().cgColor
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            borderBox.widthAnchor.constraint(equalToConstant: 450),
            borderBox.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        return borderBox
    }
    
    func customLoginButton(loginButton: NSButton) -> NSButton {
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.wantsLayer = true
        loginButton.title = "Login"
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
    
    func errorAnimation(view: NSView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(point: NSPoint(x: view.frame.origin.x - 10, y: view.frame.origin.y))
        animation.toValue = NSValue(point: NSPoint(x: view.frame.origin.x + 10, y: view.frame.origin.y))
        view.layer?.add(animation, forKey: "position")
    }
    
    @objc func authenticateUser(_ sender: NSButton) {
        
        presenter.viewDidLoad(emailId: emailTextField.stringValue, password: passwordTextField.stringValue)
    }
}

extension UserLoginPageView: GetUserViewontract {
    
    func load(success: User) {
        print("\n        login Sucessfully")
        print("        Welcome \(success.name)\n")
    }
    
    func failure(error: UserLoginError) {
        
        errorString.isHidden = false
        
    }
}
