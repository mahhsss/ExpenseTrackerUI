//
//  DeleteTransactionPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend


class DeleteTransactionPresenter {
    
    weak var view: DeleteTransactionViewContract?
    weak var router: Router?
    var deleteTransaction: DeleteTransaction
    init(deleteTransaction: DeleteTransaction) {
        self.deleteTransaction = deleteTransaction
    }
}

extension DeleteTransactionPresenter: DeleteTransactionPresenterContract {
   
    func viewLoad(user: ExpenseTrackerBackend.User, transaction: ExpenseTrackerBackend.Transaction, columnName: String, columnValue: Any) {
        let request = DeleteTransactionRequest(user: user, transaction: transaction, columnName: columnName, columnValue: columnValue)
        self.deleteTransaction.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
   
}
