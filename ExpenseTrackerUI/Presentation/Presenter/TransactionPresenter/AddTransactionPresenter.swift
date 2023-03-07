//
//  AddExpensePresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 03/03/23.
//

import Foundation
import ExpenseTrackerBackend

class AddTransactionPresenter {
   
    weak var view: AddNewTransactionContract?
    weak var router: Router?
    var newTransaction: AddNewTransaction
    
    init(AddNewTransaction: AddNewTransaction) {
        self.newTransaction = AddNewTransaction
    }
}

extension AddTransactionPresenter: AddTransactionPageContract {
    
    func viewDidLoadExpense(user: User, transaction: Transaction) {
        let request =  AddNewTransactionRequest(user: user, transaction: transaction)
        newTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
            self?.router?.addTransaction(user: user)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
            self?.router?.addTransaction(user: user)
            
        }
    }
    
}
