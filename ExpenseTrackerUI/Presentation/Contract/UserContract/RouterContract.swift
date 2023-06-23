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


protocol SignupRouterContract: AnyObject {
    
}
