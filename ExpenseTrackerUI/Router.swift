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
    
    func addExpense(user: User) {
        
        self.window.contentView = Assembler.addTransactionView(user: user, router: self, transactionType: TransactionType.spending)
    }
    
    func addIncome(user: User) {
        
        self.window.contentView = Assembler.addTransactionView(user: user, router: self, transactionType: TransactionType.income)
    }
    
    func getAllTransaction(user: User) {
        
        self.window.contentView = Assembler.getAllTransactionView(user: user, router: self)
    }
//-------------------------------------------------------------------------------------------
    
//-------------------------------------- Category -----------------------------------------------
    
    func categoryView(user: User) {
        self.window.contentView = Assembler.categoryView(user: user, router: self)
    }
    
    func getCategoryView(user: User) {
        self.window.contentView = Assembler.getCategory(user: user, router: self)
    }
    
    func addCategory(user: User) {
        self.window.contentView = Assembler.addCategory(user: user, router: self)
    }
    
//-------------------------------------- Analysis -----------------------------------------------
    func getAnalysis(user: User) {
        self.window.contentView = Assembler.getAnalysisView(user: user, router: self)
    }
    
    func getMonthlyAnalysis(user: User) {
        self.window.contentView = Assembler.getMonthlyTransactionAnalysis(user: user, router: self)
    }
    
    func getYearlyAnalysis(user: User) {
        self.window.contentView = Assembler.getYearlyTransactionAnalysis(user: user, router: self)
    }
    
    func getWeeklyAnalysis(user: User) {
        self.window.contentView = Assembler.getWeeklyTransactionAnalysis(user: user, router: self)
    }
}

