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
    
    var presenter: UserLoginPresenterContract
    init(presenter: UserLoginPresenterContract) {
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            userLogin()
        }
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
}

extension UserLoginPageView: GetUserViewontract {
    func load(success: ExpenseTrackerBackend.User) {
        print("\n        login Sucessfully")
        print("        Welcome \(success.name)\n")
    }
    
    func failure(error: ExpenseTrackerBackend.UserLoginError) {
        print("\n\(error.error)\nEnter valid Credentials\n")
    }
    
    
    
}
