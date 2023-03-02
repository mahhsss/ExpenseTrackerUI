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
    
//--------------------------------- Authentication ------------------------------------------
    func userSignUp() {
        
        self.window.contentView = Assembler.addUserView(router: self)
    }
    
    func userLogIn() {
        
        self.window.contentView = Assembler.userLoginView(router: self)
    }
//-------------------------------------------------------------------------------------------
    
//-------------------------------------- Home -----------------------------------------------
    
    
    
    func launch() {
        self.window.contentView = Assembler.AuthenticationView(router: self)
    }
}
