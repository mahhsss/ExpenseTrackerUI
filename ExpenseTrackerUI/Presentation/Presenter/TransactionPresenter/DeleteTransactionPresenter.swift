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
    var deleteTransaction: DeleteTransaction
    init(deleteTransaction: DeleteTransaction) {
        self.deleteTransaction = deleteTransaction
    }
}

extension DeleteTransactionPresenter: DeleteTransactionPresenterContract {
   
    func viewLoad(transactionId: Int) {
        let request = DeleteTransactionRequest(transactionId: transactionId)
        self.deleteTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: response.message)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error.error.localizedDescription)
        }
    }
   
}
