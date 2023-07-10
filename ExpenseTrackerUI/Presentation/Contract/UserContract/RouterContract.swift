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
}


protocol LoginRouterContract: AnyObject {
    
    func homePage(user: User)
    func loginPage()
}

protocol NewTransactionRouterContract: AnyObject {
    
    func reloadAfterNewTransaction(transaction: Transaction)
}

protocol UpdateBudgetRouterContract: AnyObject {
    
    func loadBudgetAfterUpdating(budget: Int)
}

protocol HomePageRouterContract: AnyObject, NewTransactionRouterContract, UpdateBudgetRouterContract, LogOutRouterContract {
    
    func launch()
    var homePageViewController: HomePageViewController? { get set }
    func updateBudget(user: User, router: UpdateBudgetRouterContract) -> AddBudgetView
}
