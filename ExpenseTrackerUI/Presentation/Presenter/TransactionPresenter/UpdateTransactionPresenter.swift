//
//  UpdateTransactionPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend

class UpdateTransactionPresenter {
    
    weak var view: UpdateTransactionViewContract?
    var updateTransaction: UpdateTransaction
    
    init(updateTransaction: UpdateTransaction) {
        self.updateTransaction = updateTransaction
    }
}

extension UpdateTransactionPresenter : UpdateTransactionPresenterContract {
    
    func viewLoadTransaction(user: User, transation: Transaction, column: String, update: Any) {
        let request = UpdateTransactionRequest(userId: user.userId, column: column, update: update, transaction: transation)
        self.updateTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.faliure(error: error)
        }
        
    }
}
