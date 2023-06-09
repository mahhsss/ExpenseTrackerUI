//
//  AddBudgetPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import ExpenseTrackerBackend

class AddBudgetPresenter {
    
    weak var view: AddBudgetViewContract?
    weak var router: Router?
    var addBudget: AddBudget
    
    init(addBudget: AddBudget) {
        self.addBudget = addBudget
    }
}
extension AddBudgetPresenter: AddBudgetPresenterContract {
    
    func viewLoadBudget(user: ExpenseTrackerBackend.User, budget: ExpenseTrackerBackend.Budget) {
        let request = AddBudgetRequest(userId: user.userId, budget: budget)
        self.addBudget.execute(request: request) { response in
            self.view?.load(success: response)
        } onFailure: { error in
            self.view?.failure(error: error)
        }
    }
}
