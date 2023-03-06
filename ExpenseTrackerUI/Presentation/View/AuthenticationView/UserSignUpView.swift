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
    
        var presenter: UserSignUpPagePresenterContract
        var user: User?
        
        init(presenter: AddNewUserPresenter) {
            self.presenter = presenter
            super.init(frame: NSZeroRect)
        }
        
        required init?(coder decoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidMoveToSuperview() {
            if superview != nil {
                userSignUp()
            }
        }
}

extension UserSignUpPageView: AddNewUserViewContract {
    
    func userSignUp() {
        
        print("Enter Name")
        let name = readLine()!
        print("\nEnter Email Id")
        let emailId = readLine()!
        print("\nEnter Password")
        let password = readLine()!
        user = User(userId: 0, name: name, emailId: emailId, password: password)
        presenter.viewLoad(user: user!)
    }
    
    func load(sucess: AddnewUserResponse) {
        print("\n\(sucess.message)\n")
        
    }
    
    func failure(error: AddNewUserError) {
        print("\n\(error.error)\nEmailId already there\n")
    }
}

