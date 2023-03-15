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
    
    var user: User
    var presenter: DeleteTransactionPresenterContract
    var transaction: Transaction
    init(user: User, presenter: DeleteTransactionPresenterContract, transaction: Transaction) {
        self.user = user
        self.presenter = presenter
        self.transaction = transaction
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            deleteTransaction()
        }
    }
    
    func deleteTransaction() {
        presenter.viewLoad(user: user, transaction: transaction, columnName: "transactionId", columnValue: 1)
    }
}
extension DeleteTransactionView: DeleteTransactionViewContract {
    
    func load(success: ExpenseTrackerBackend.DeleteTransactionResponse) {
        print("\n\(success.message)\n")
    }
    
    func failure(error: ExpenseTrackerBackend.DeleteTransactionError) {
        print("\n\(error.error)\n")
    }
}
