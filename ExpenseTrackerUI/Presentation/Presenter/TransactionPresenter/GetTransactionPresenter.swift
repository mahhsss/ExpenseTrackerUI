//
//  GetTransactionPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetAllTransactionPresenter {
    
    weak var view: GetAllTransactionViewContract?
    weak var router: Router?
    var getAllTransaction: GetAllTransaction
    
    init(getAllTransaction: GetAllTransaction) {
        self.getAllTransaction = getAllTransaction
    }
    
}

extension GetAllTransactionPresenter: GetAllTranasctionPresenterContract {
    
    func viewLoadTransaction(user: User) {
        let request = GetAllTransactionRequest(userId: user.userId)
        getAllTransaction.execute(request: request) { response in
            self.view?.load(success: response)
//            self.router?.updateTransaction(user: user, transaction: response.transactions[0])
//            self.router?.deleteTransaction(user: user, transaction: response.transactions[0])
            self.router?.addBudget(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.categoryView(user: user)
        }
    }
}
