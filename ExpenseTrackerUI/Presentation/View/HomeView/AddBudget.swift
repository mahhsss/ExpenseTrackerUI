//
//  AddBudget.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddBudgetView: NSView {
    
    var user: User
    var presenter: AddBudgetPresenterContract
    init(user: User, presenter: AddBudgetPresenterContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            addBudget()
        }
    }
    
    func addBudget() {
        let budget = Budget(budget: 15_000, month: "2023-02")
        presenter.viewLoadBudget(user: user, budget: budget)
    }
}


extension AddBudgetView: AddBudgetViewContract {
    
    func load(success: AddBudgetResponse) {
        print("\n\(success.message)\n")
    }
    
    func failure(error: AddBudgetError) {
        print("\n\(error.error)\n")
    }
}
