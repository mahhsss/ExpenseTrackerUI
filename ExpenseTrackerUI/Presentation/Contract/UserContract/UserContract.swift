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

protocol UpdateUserPresenterContract: AnyObject {
    func viewLoad(user: User, column: String, update: Any)
}

protocol UpdateUserViewContract: AnyObject {
    func load(success: UpdateUserResponse)
    func failure(error: UpdateUserError)
}
//------------------------------------------------------------------------------


//------------------------ AddTransaction Contracts ----------------------------
protocol AddTransactionPageContract: AnyObject {
    func viewDidLoadExpense(user: User, transaction: Transaction)
}

protocol AddNewTransactionContract: AnyObject {
    func load(success: AddNewTransactionResponse)
    func failure(error: AddNewTransactionError)
}
//------------------------------------------------------------------------------

//------------------------ GetTransaction Contracts ----------------------------
protocol GetAllTranasctionPresenterContract: AnyObject {
    func viewLoadTransaction(user: User)
}

protocol GetAllTransactionViewContract: AnyObject {
    func load(success: GetAllTransactionResponse)
    func failure(error: GetAllTransactionError)
}
//------------------------------------------------------------------------------

//------------------------ UpdateTransaction Contracts ----------------------------
protocol UpdateTransactionPresenterContract: AnyObject {
    func viewLoadTransaction(user: User, transation: Transaction, column: String, update: Any)
}

protocol UpdateTransactionViewContract: AnyObject {
    func load(success: UpdateTransactionResponse)
    func faliure(error: UpdateTransactionError)
}
//------------------------------------------------------------------------------

//------------------------ GetCategory Contracts -------------------------------
protocol GetCategoryPresenterContract: AnyObject {
    func viewLoad(user: User)
}

protocol GetCategoryViewContract: AnyObject {
    func load(success: GetCategoryResponse)
    func failure(error: GetCategoryError)
}
//------------------------------------------------------------------------------

//------------------------ AddCategory Contracts ----------------------------
protocol AddCategoryPageContract: AnyObject {
    func viewDidLoadExpense(user: User, category: ExpendatureCategory)
}

protocol AddCategoryViewContract: AnyObject {
    func load(sucess: AddCategoryResponse)
    func failure(error: AddCategoryError)
}
//------------------------------------------------------------------------------

//------------------------ GetMonthlyTransactionAnalysis Contracts ----------------------------
protocol GetMonthlyTranasctionAnalysisPresenterContract: AnyObject {
    func viewLoadMonthyTransaction(user: User, startDate: String, endDate: String)
}

protocol GetMonthlyTransactionAnalysisViewContract: AnyObject {
    func load(success: GetTransactionAnalysisResponse)
    func failure(error: GetTransactionAnalysisError)
}
//------------------------------------------------------------------------------

//------------------------ GetyearlyTransactionAnalysis Contracts ----------------------------
protocol GetYearlyTransactionAnalysisPresenterContract: AnyObject {
    func viewLoadYearlyTransaction(user: User, startDate: String, endDate: String)
}

protocol GetYearlyTransactionAnalysisViewContract: AnyObject {
    func load(success: GetTransactionAnalysisResponse)
    func failure(error: GetTransactionAnalysisError)
}
//------------------------------------------------------------------------------

//------------------------ GetyearlyTransactionAnalysis Contracts ----------------------------
protocol GetWeeklyTransactionAnalysisPresenterContract: AnyObject {
    func viewLoadWeeklyTransaction(user: User, startDate: String, endDate: String)
}

protocol GetWeeklyTransactionAnalysisViewContract: AnyObject {
    func load(success: GetTransactionAnalysisResponse)
    func failure(error: GetTransactionAnalysisError)
}
