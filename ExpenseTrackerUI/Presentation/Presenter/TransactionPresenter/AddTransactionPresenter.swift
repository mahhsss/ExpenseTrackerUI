//
//  AddExpensePresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 03/03/23.
//

import Foundation
import ExpenseTrackerBackend

class AddTransactionPresenter {
   
    weak var view: AddNewTransactionContract?
    weak var reloader: ToolBar?
    weak var windowController: AddFloatingWindow?
    var newTransaction: AddNewTransaction
    
    init(AddNewTransaction: AddNewTransaction) {
        self.newTransaction = AddNewTransaction
    }
}

extension AddTransactionPresenter: AddTransactionContract {
    
    func viewDidLoadExpense(user: User, transaction: Transaction) {
        let request =  AddNewTransactionRequest(userId: user.userId, transaction: transaction)
        newTransaction.execute(request: request) { [weak self] response in
            self?.view?.load(success: response.message)
            self?.reloader?.reload(transaction: transaction)
            self?.windowController?.close()
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error.error.localizedDescription)
            self?.reloader?.reload(transaction: transaction)
            self?.windowController?.close()
        }
    }
    
}
