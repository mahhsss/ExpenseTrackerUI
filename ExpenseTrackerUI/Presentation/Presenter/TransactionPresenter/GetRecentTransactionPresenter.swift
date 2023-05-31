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
    weak var router: Router?
    var getRecentTransaction: GetRecentTransaction
    
    init(getRecentTransaction: GetRecentTransaction) {
        self.getRecentTransaction = getRecentTransaction
    }
}

extension GetRecentTranasactionPresenter: GetRecentTransactionPresenterContract {
    func viewLoadTransaction(user: User, month: String) {
        
        let request = GetRecentTransactionRequest(userId: user.userId, month: month)
        getRecentTransaction.execute(request: request) { response in
            self.view?.load(success: response)
        } onFailure: { error in
            self.view?.failure(error: error)
        }
    }
}
