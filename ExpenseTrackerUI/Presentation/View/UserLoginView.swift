//
//  UserView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit


class AddNewUserView: NSView {
    
    var presenter: AddNewUserPresenterContract
    var user: User
    
    init(presenter: AddNewUserPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSZeroRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            presenter.viewLoaded(user: user)
        }
    }
}

extension AddNewUserView: AddNewUserViewContract {
    
    func failure() {
        print("Not able to create account!..")
        print("Please try some other time..")
    }
    
    func load() {
        print("You have signed up ..")
        print("Login with userName and Password ..")
    }
}
