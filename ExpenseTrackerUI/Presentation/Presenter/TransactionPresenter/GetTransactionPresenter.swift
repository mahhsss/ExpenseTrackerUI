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
        var request = GetAllTransactionRequest(user: user)
        getAllTransaction.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
}
