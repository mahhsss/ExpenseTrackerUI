//
//  Router.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class Router: AddUserRouterContract {
    func selected() {
        print("Process Completed")
    }
    
    
    var window: NSWindow
    init(window: NSWindow) {
        self.window = window
    }
    
    func userSignUp() {
        
        self.window.contentView = Assembler.addUserView(router: self)
    }
    
    func userLogIn() {
        
        self.window.contentView = Assembler.userLoginView(router: self)
    }
    
    
    func launch() {
        
        let userView = UserView(router: self)
        userView.AuthenticationView()
    }
}
