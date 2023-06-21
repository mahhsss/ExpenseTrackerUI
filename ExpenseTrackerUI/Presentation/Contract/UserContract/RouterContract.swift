//
//  RouterContract.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 21/06/23.
//

import Foundation
import ExpenseTrackerBackend

protocol GetBudgetRouterContract: AnyObject {
    
    func reloadHomePage(user: User)
}

protocol AddBudgetRouterContract: AnyObject {
    
    func reloadHomePage(user: User)
}

protocol LogOutRouterContract: AnyObject {
    
    func logout()
}
