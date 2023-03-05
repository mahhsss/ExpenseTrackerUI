//
//  Router.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class Router {
    
    var window: NSWindow
    init(window: NSWindow) {
        self.window = window
    }
    
    func launch() {
        self.window.contentView = Assembler.AuthenticationView(router: self)
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
    func addTransaction(user: User) {
        
        self.window.contentView = Assembler.homePageView(router: self, user: user)
    }
    
    func addExpenseTracker(user: User) {
        
        self.window.contentView = Assembler.addExpenseView(user: user, router: self)
    }
    
    
}
