//
//  UpdateTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class UpdateTransactionView: NSView {
    
    var user: User
    var presenter: UpdateTransactionPresenterContract
    var transaction: Transaction
   
    init(user: User, presenter: UpdateTransactionPresenterContract, transaction: Transaction) {
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
            updateTransactionView()
        }
    }
    
    func updateTransactionView() {
        
        presenter.viewLoadTransaction(user: user, transation: transaction, column: "amount", update: 696969)
    }
}

extension UpdateTransactionView: UpdateTransactionViewContract {
    
    func load(success: UpdateTransactionResponse) {
        print("\n\(success.message)\n")
    }
    
    func faliure(error: UpdateTransactionError) {
        print("\n\(error.error)\n")
    }
}
