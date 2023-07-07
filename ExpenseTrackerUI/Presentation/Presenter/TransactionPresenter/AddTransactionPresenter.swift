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
    weak var router: NewTransactionRouterContract?
    var newTransaction: AddNewTransaction
    
    init(AddNewTransaction: AddNewTransaction) {
        self.newTransaction = AddNewTransaction
    }
}

extension AddTransactionPresenter: AddTransactionContract {
    
    func viewDidLoadExpense(user: User, transaction: Transaction) {
        let request =  AddNewTransactionRequest(userId: user.userId, transaction: transaction)
        newTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: "transaction added successfully")
            var transaction2 = transaction
            transaction2.transactionId = response.transactionId
            self?.router?.reloadAfterNewTransaction(transaction: transaction2)
            self?.router?.closeAddTransactionWindow()
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error.error.localizedDescription)
            self?.router?.reloadAfterNewTransaction(transaction: transaction)
            self?.router?.closeAddTransactionWindow()
        }
    }
    
}
