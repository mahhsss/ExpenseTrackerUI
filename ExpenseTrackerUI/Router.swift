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
    
    func home(user: User) {
        self.window.contentViewController = Assembler.HomeView(user: user, router: self)
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
//    func addTransaction(user: User, windowController: AddFloatingWindow, reloader: ToolBar) {
//        self.window.contentView = Assembler.addTransactionView(user: user, router: self, windowController: windowController, reloader: reloader)
//    }
//    
//    func getAllTransaction(user: User) {
//        self.window.contentView = Assembler.getAllTransactionView(user: user)
//    }
//    
//    func updateTransaction(user: User, transaction: Transaction) {
//        
//        self.window.contentView = Assembler.updateTransactionView(user: user, transaction: transaction, router: self)
//    }
//    
//    func updateUser(user: User) {
//        self.window.contentView = Assembler.updateUserView(user: user, router: self)
//    }
//    
//    func deleteTransaction(user: User, transaction: Transaction) {
//        self.window.contentView = Assembler.deleteTransaction(user: user, transaction: transaction, router: self)
//    }
//    
//    func addMonthlyAnalysisTransaction(user: User, transaction: Transaction) {
//        self.window.contentView = Assembler.addMonthlyAnalysisTransaction(user: user, transaction: transaction, router: self)
//    }
//    
//    func getMonthlySpent(user: User) {
//        self.window.contentView = Assembler.getMonthlySpent(user: user)
//    }
////-------------------------------------------------------------------------------------------
//    
////-------------------------------------- Category -----------------------------------------------
//    
//    func categoryView(user: User) {
//        self.window.contentView = Assembler.categoryView(user: user, router: self)
//    }
//    
//    func getCategoryView(user: User) {
//        self.window.contentView = Assembler.getCategory(user: user, router: self)
//    }
//    
//    func addCategory(user: User) {
//        self.window.contentView = Assembler.addCategory(user: user, router: self)
//    }
//    
////-------------------------------------- Analysis -----------------------------------------------
//    func getAnalysis(user: User) {
//        self.window.contentView = Assembler.getAnalysisView(user: user, router: self)
//    }
//    
//    func getMonthlyAnalysis(user: User) {
//        self.window.contentView = Assembler.getMonthlyTransactionAnalysis(user: user, router: self)
//    }
//    
//    func getYearlyAnalysis(user: User) {
//        self.window.contentView = Assembler.getYearlyTransactionAnalysis(user: user, router: self)
//    }
//    
//    func getWeeklyAnalysis(user: User) {
//        self.window.contentView = Assembler.getWeeklyTransactionAnalysis(user: user, router: self)
//    }
}

extension Router: GetBudgetRouterContract, AddBudgetRouterContract {
    
    func reloadHomePage(user: User) {
        self.window.contentViewController = Assembler.HomeView(user: user, router: self)
    }
}

extension Router: LogOutRouterContract {
    
    func logout() {
        self.window.contentViewController = Assembler.AuthenticationView(router: self)
    }
}

