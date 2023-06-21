//
//  AuthenticationViewController.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/05/23.
//

import Foundation
import AppKit


class AuthenticationViewController: NSViewController {
    
    var loginView: UserLoginPageView
    var signupView: UserSignUpPageView!
    weak var router: Router!
    
    init(router: Router) {
        
//        self.router = router
        self.loginView = Assembler.userLoginView(router: router)
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
        configureHeading()
        configureLoginView()
    }
    
    func configureHeading() {
        
        let appName = CustomText.customHeaderStringLabel(label: "EXPENZO", fontSize: 60, fontStyle: "Beatrick")
        appName.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appName)
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            appName.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -700),
            appName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureLoginView() {
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.wantsLayer = true
        loginView.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        loginView.layer?.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            loginView.heightAnchor.constraint(equalToConstant: 632),
            loginView.widthAnchor.constraint(equalToConstant: 812),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        
        let singleClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(moveToSignUp(sender:)))
        loginView.signUpLabel.addGestureRecognizer(singleClickRecognizer)
        singleClickRecognizer.numberOfClicksRequired = 1
    }
    
    func configureSignupView() {
        
        signupView.translatesAutoresizingMaskIntoConstraints = false
        signupView.wantsLayer = true
        signupView.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        signupView.layer?.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            signupView.heightAnchor.constraint(equalToConstant: 632),
            signupView.widthAnchor.constraint(equalToConstant: 812),
            signupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70)
        ])
        
        let singleClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(moveToLogin(sender:)))
        signupView.loginLabel.addGestureRecognizer(singleClickRecognizer)
        singleClickRecognizer.numberOfClicksRequired = 1
    }
    
    @objc func moveToSignUp(sender: NSClickGestureRecognizer) {
        
        self.signupView = Assembler.addUserView(router: router)
        view.addSubview(signupView)
        loginView.isHidden = true
        signupView.isHidden = false
        configureSignupView()
        view.window?.makeFirstResponder(signupView.nameTextField)
    }
    
    @objc func moveToLogin(sender: NSClickGestureRecognizer) {
        signupView.isHidden = true
        loginView.isHidden = false
        view.window?.makeFirstResponder(loginView.emailTextField)
    }
}

