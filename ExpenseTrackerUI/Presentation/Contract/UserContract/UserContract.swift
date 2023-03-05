//
//  UserContract.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend


//------------------------ Authentication Contracts -----------------------

protocol AddNewUserPresenterContract: AnyObject {
    
    func viewLoaded(user: User)
}

protocol AddNewUserViewContract: AnyObject {
    
    func load(sucess: AddnewUserResponse)
    func failure(error: AddNewUserError)
}

protocol GetUserViewontract: AnyObject {
    func load(success: User)
    func failure(error: UserLoginError)
}

protocol UserLoginPresenterContract: AnyObject {
    func viewDidLoad(emailId: String, password: String)
}

protocol UserSignUpPagePresenterContract: AnyObject {
    func viewLoad(user: User)
}
//--------------------------------------------------------------------------


//------------------------ AddExpense Contracts ----------------------------
protocol AddExpensePageContract: AnyObject {
    func viewDidLoad(user: User, transaction: Transaction)
}

protocol AddNewExpenseContract: AnyObject {
    func load(success: AddNewTransactionResponse)
    func failure(error: AddNewTransactionError)
}

