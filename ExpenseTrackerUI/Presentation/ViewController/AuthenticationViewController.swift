//
//  AuthenticationViewController.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/05/23.
//

import Foundation
import AppKit


class AuthenticationViewController: NSViewController {
    
    let loginView: UserLoginPageView
    let signupView: UserSignUpPageView
    
    init(router: Router) {
        
        self.loginView = Assembler.userLoginView(router: router)
        self.signupView = Assembler.addUserView(router: router)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height))
    }
    
    override func viewDidLoad() {
        
        view.addSubview(loginView)
        view.addSubview(signupView)
        configureHeading()
        configureLoginView()
        configureSignupView()
        signupView.isHidden = true
    }
    
    func configureHeading() {
        
        print("header is called")
        let appName = customStringLabel(label: "EXPENZO", fontSize: 60, fontStyle: "Beatrick")
        appName.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appName)
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            appName.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -700),
            appName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureLoginView() {
        
        print("login view is called")
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.wantsLayer = true
        loginView.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        loginView.layer?.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            loginView.heightAnchor.constraint(equalToConstant: (view.frame.maxY) - 350),
            loginView.widthAnchor.constraint(equalToConstant: (view.frame.maxX) - 700),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        
        let singleClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(moveToSignUp(sender:)))
        loginView.signUpLabel.addGestureRecognizer(singleClickRecognizer)
        singleClickRecognizer.numberOfClicksRequired = 1
    }
    
    func configureSignupView() {
        
        print("signUp view is called")
        signupView.translatesAutoresizingMaskIntoConstraints = false
        signupView.wantsLayer = true
        signupView.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        signupView.layer?.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            signupView.heightAnchor.constraint(equalToConstant: (view.frame.maxY) - 350),
            signupView.widthAnchor.constraint(equalToConstant: (view.frame.maxX) - 700),
            signupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        
        let singleClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(moveToLogin(sender:)))
        signupView.loginLabel.addGestureRecognizer(singleClickRecognizer)
        singleClickRecognizer.numberOfClicksRequired = 1
    }
    
    func customStringLabel(label: String, fontSize: Int, fontColor: NSColor? = nil, fontStyle: String? = nil) -> NSTextField {
        
        let textField = NSTextField(labelWithString: label)
        textField.font = .systemFont(ofSize: CGFloat(fontSize))
        if let fontColor = fontColor {
            textField.textColor = fontColor
        }
        if let fontStyle = fontStyle {
            textField.font = NSFont(name: fontStyle, size: CGFloat(fontSize))
        }
        textField.isEditable = false
        textField.isSelectable = false
        
        let attributedString = NSMutableAttributedString(string: label)
        let range = NSRange(location: 0, length: attributedString.length)
        let borderColor: CGColor = .init(srgbRed: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 1)
        let borderWidth: CGFloat = 2.0
        attributedString.addAttribute(.strokeColor, value: borderColor, range: range)
        attributedString.addAttribute(.strokeWidth, value: -borderWidth, range: range)

        textField.attributedStringValue = attributedString
        return textField
    }
    
    @objc func moveToSignUp(sender: NSClickGestureRecognizer) {
        loginView.isHidden = true
        signupView.isHidden = false
        view.window?.makeFirstResponder(signupView.nameTextField)
    }
    
    @objc func moveToLogin(sender: NSClickGestureRecognizer) {
        signupView.isHidden = true
        loginView.isHidden = false
        view.window?.makeFirstResponder(loginView.emailTextField)
    }
}

