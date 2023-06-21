//
//  AddMonthlyAnalysisView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddMonthlyAnalysisView: NSView {
    
    var presenter: AddMonthlyAnalysisPresenterContract
    var user: User
    var transaction: Transaction
    init(user: User, presenter: AddMonthlyAnalysisPresenterContract, transaction: Transaction) {
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
            addMonthlyAnalysis()
        }
    }
    
    func addMonthlyAnalysis() {
        self.presenter.viewLoadTransaction(user: user, transaction: transaction)
    }
    
}

extension AddMonthlyAnalysisView: AddMonthlyAnalysisViewContract {
    
    func load(success: String) {
        print("\n\(success)\n")
    }
    
    func failure(error: String) {
        print("\n\(error)\n")
    }
}
