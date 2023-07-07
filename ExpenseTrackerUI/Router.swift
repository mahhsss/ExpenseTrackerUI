//
//  Router.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class Router: HomePageRouterProtocol {
    
    
    var window: NSWindow
    var addFloatingWindow: AddFloatingWindow?
    var homePageViewController: HomePageViewController?
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

extension Router: NewTransactionRouterContract {
    
    func createAddTransactionFloatingWindow(user: User) -> AddFloatingWindow {
        addFloatingWindow = AddFloatingWindow(user: user, router: self)
        return addFloatingWindow!
    }
    
    func reloadAfterNewTransaction(transaction: Transaction) {
        homePageViewController?.reloadAfterNewtransaction(transaction: transaction)
    }
}


extension Router {
    
    func closeAddTransactionWindow() {
        
        addFloatingWindow?.close()
    }
}


extension Router: UpdateBudgetRouterContract {
    
    func updateBudget(user: User) -> AddBudgetView {
        return Assembler.addBudget(user: user, router: self)
    }
    
    func loadBudgetAfterUpdating(budget: Int) {
        
        homePageViewController?.loadBudgetAfterUpdating(budget: budget)
    }
}
