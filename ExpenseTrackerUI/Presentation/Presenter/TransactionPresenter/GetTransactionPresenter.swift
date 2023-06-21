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
    var getAllTransaction: GetAllTransaction
    
    init(getAllTransaction: GetAllTransaction) {
        self.getAllTransaction = getAllTransaction
    }
    
}

extension GetAllTransactionPresenter: GetAllTranasctionPresenterContract {
    
    func viewLoadTransaction(user: User) {
        let request = GetAllTransactionRequest(userId: user.userId)
        getAllTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
}
