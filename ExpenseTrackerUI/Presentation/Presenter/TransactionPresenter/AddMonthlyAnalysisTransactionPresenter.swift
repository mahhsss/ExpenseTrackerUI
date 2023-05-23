//
//  AddMonthlyAnalysisTransactionPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import ExpenseTrackerBackend

class AddMonthlyAnalysisTransactionPresenter {
    
    weak var view: AddMonthlyAnalysisViewContract?
    weak var router: Router?
    var AddMonthlyAnalysisTransaction: AddMonthlyAnalysisTransaction
    
    init(AddMonthlyAnalysisTransaction: AddMonthlyAnalysisTransaction) {
        self.AddMonthlyAnalysisTransaction = AddMonthlyAnalysisTransaction
    }
}

extension AddMonthlyAnalysisTransactionPresenter: AddMonthlyAnalysisPresenterContract {
    
    func viewLoadTransaction(user: User, transaction: Transaction) {
        let request = AddMonthlyAnalysisTransactionRequest(userId: user.userId, transaction: transaction)
        self.AddMonthlyAnalysisTransaction.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
}
