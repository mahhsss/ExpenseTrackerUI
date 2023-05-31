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
protocol AddTransactionContract: AnyObject {
    func viewDidLoadExpense(user: User, transaction: Transaction)
}

protocol AddNewTransactionContract: AnyObject {
    func load(success: AddNewTransactionResponse)
    func failure(error: AddNewTransactionError)
}
//------------------------------------------------------------------------------

//------------------------ AddBudget Contracts ---------------------------------
protocol AddBudgetPresenterContract: AnyObject {
    func viewLoadBudget(user: User, budget: Budget)
}
protocol AddBudgetViewContract: AnyObject {
    func load(success: AddBudgetResponse)
    func failure(error: AddBudgetError)
}
//------------------------ GetBudget Contracts ---------------------------------
protocol GetBudgetPresenterContract: AnyObject {
    func viewLoadBudget(user: User, month: String)
}
protocol GetBudgetViewContract: AnyObject {
    func load(success: GetBudgetResponse)
    func failure(error: GetBudgetError)
}
//------------------------------------------------------------------------------

//---------------------- AddMonthlyAnalysis Contracts --------------------------
protocol AddMonthlyAnalysisPresenterContract: AnyObject {
    func viewLoadTransaction(user: User, transaction: Transaction)
}

protocol AddMonthlyAnalysisViewContract: AnyObject {
    func load(success: AddMonthlyAnalysisTransactionResponse)
    func failure(error: AddMonthlyAnalysisTransactionError)
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
//------------------------ GetRecentTransaction Contracts ----------------------------
protocol GetRecentTransactionPresenterContract: AnyObject {
    func viewLoadTransaction(user: User, month: String)
}
protocol GetRecentTransactionViewContract: AnyObject {
    func load(success: GetRecentTransactionResponse)
    func failure(error: GetRecentTransactionError)
}
//------------------------------------------------------------------------------

//------------------------ DeleteTransaction Contracts -------------------------
protocol DeleteTransactionPresenterContract: AnyObject {
    func viewLoad(user: User, transaction: Transaction, columnName: String, columnValue: Any)
}

protocol DeleteTransactionViewContract: AnyObject {
    func load(success: DeleteTransactionResponse)
    func failure(error: DeleteTransactionError)
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
//------------------------ GetMonthlySpent Contracts ----------------------------
protocol GetMonthlySpentPresenterContract: AnyObject {
    func viewLoadMonthlySpent(user: User, month: String)
}
 
protocol GetMonthlySpentViewContract: AnyObject {
    func load(success: GetMonthlySpentResponse)
    func failure(error: GetMonthlySpentError)
}
//------------------------ GetMonthlyIncome Contracts ----------------------------
protocol GetMonthlyIncomePresenterContract: AnyObject {
    func viewLoadMonthlySpent(user: User, month: String)
}
 
protocol GetMonthlyIncomeViewContract: AnyObject {
    func load(success: GetMonthlyIncomeResponse)
    func failure(error: GetMonthlyIncomeError)
}
//------------------------ GetMonthlyBalance Contracts ----------------------------
protocol GetMonthlyBalancePresenterContract: AnyObject {
    func viewLoadMonthlyBalance(user: User, month: String)
}
protocol GetMonthlyBalanceViewContract: AnyObject {
    func load(success: GetMonthlyBalanceResponse)
    func failure(error: GetMonthlyBalanceError)
}
