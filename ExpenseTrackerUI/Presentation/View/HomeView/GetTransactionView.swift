//
//  GetTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetAllTransactionView: NSView {
    
    var presenter: GetAllTranasctionPresenterContract
    var user: User
    init(user: User, presenter: GetAllTranasctionPresenterContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getTransaction()
        }
    }
    
    func getTransaction() {
        presenter.viewLoadTransaction(user: user)
    }
}


extension GetAllTransactionView: GetAllTransactionViewContract {
    
    func load(success: GetAllTransactionResponse) {
        print("\n\(success.transactions)\n")
    }
    
    func failure(error: GetAllTransactionError) {
        print("\n\(error.error)\n")
    }
    
    
}
