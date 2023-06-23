//
//  GetRecentTransactionPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 31/05/23.
//

import Foundation
import ExpenseTrackerBackend

class GetRecentTranasactionPresenter {
    
    weak var view: GetRecentTransactionViewContract?
    var getRecentTransaction: GetRecentTransaction
    
    init(getRecentTransaction: GetRecentTransaction) {
        self.getRecentTransaction = getRecentTransaction
    }
}

extension GetRecentTranasactionPresenter: GetRecentTransactionPresenterContract {
    
    func viewLoadTransaction(user: User, month: String) {
        let request = GetRecentTransactionRequest(userId: user.userId, month: month)
        getRecentTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(transaction: response.transactions)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error.error.localizedDescription)
        }
    }
}
