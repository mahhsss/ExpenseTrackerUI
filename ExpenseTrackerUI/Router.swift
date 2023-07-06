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
        self.window.contentViewController = Assembler.AuthenticationView(router: self)
    }
}

extension Router: LogOutRouterContract {
    
    func logout() {
        window.toolbar = nil
        self.window.contentViewController = Assembler.AuthenticationView(router: self)
    }
}

extension Router: LoginRouterContract {
    
    func loginPage() {
        self.window.contentViewController = Assembler.AuthenticationView(router: self)
    }
      
    func homePage(user: User) {
        self.window.contentViewController = Assembler.HomeView(user: user, router: self)
    }
}

extension Router {
    
    func createAddTransactionFloatingWindow(user: User, router: HomePageViewController) {
        
    }
}
