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
    weak var router: Router?
    var updateTransaction: UpdateTransaction
    
    init(updateTransaction: UpdateTransaction) {
        self.updateTransaction = updateTransaction
    }
}

extension UpdateTransactionPresenter : UpdateTransactionPresenterContract {
    
    func viewLoadTransaction(user: User, transation: Transaction, column: String, update: Any) {
        let request = UpdateTransactionRequest(user: user, column: column, update: update, transaction: transation)
        self.updateTransaction.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.categoryView(user: user)
        } onFailure: { error in
            self.view?.faliure(error: error)
            self.router?.categoryView(user: user)
        }
        
    }
}
