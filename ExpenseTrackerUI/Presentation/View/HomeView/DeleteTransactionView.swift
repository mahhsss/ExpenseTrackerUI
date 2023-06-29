//
//  DeleteTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class DeleteTransactionView: NSView {
    
    var presenter: DeleteTransactionPresenterContract
    var transactionId: Int
    init(presenter: DeleteTransactionPresenterContract, transactionId: Int) {
        self.presenter = presenter
        self.transactionId = transactionId
        super.init(frame: NSRect())
        deleteTransaction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deleteTransaction() {
        presenter.viewLoad(transactionId: transactionId)
    }
}
extension DeleteTransactionView: DeleteTransactionViewContract {
    
    func load(success: String) {
//        print("\n\(success)\n")
    }
    
    func failure(error: String) {
        print("\n\(error)\n")
    }
}
