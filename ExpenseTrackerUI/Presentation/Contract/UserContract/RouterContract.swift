//
//  RouterContract.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 21/06/23.
//

import Foundation
import ExpenseTrackerBackend

protocol AddBudgetRouterContract: AnyObject {
    
    func reloadHomePage(user: User)
}

protocol LogOutRouterContract: AnyObject {
    
    func logout()
    func closeAddTransactionWindow()
}


protocol LoginRouterContract: AnyObject {
    
    func homePage(user: User)
    func loginPage()
}

protocol NewTransactionRouterContract: AnyObject {
    
    func reloadAfterNewTransaction(transaction: Transaction)
    func closeAddTransactionWindow()
}

protocol UpdateBudgetRouterContract: AnyObject {
    
    func loadBudgetAfterUpdating(budget: Int)
}

protocol HomePageRouterProtocol: AnyObject, NewTransactionRouterContract, UpdateBudgetRouterContract, LogOutRouterContract {
    
    var homePageViewController: HomePageViewController? { get set }
    func createAddTransactionFloatingWindow(user: User) -> AddFloatingWindow
    func updateBudget(user: User) -> AddBudgetView
}
