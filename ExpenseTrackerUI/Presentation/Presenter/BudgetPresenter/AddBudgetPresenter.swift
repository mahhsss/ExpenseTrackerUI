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
//    weak var budgetViewReloader: HomePageViewController?
    weak var router: UpdateBudgetRouterContract?
    var addBudget: AddBudget
    
    init(addBudget: AddBudget) {
        self.addBudget = addBudget
    }
}
extension AddBudgetPresenter: AddBudgetPresenterContract {
    
    func viewLoadBudget(user: User, budget: Budget) {
        let request = AddBudgetRequest(userId: user.userId, budget: budget)
        self.addBudget.execute(request: request) { [weak self] response in
            self?.view?.load(success: response.message)
//            self?.budgetViewReloader?.loadBudgetAfterUpdating(budget: budget.budget)
            self?.router?.loadBudgetAfterUpdating(budget: budget.budget)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error.error.localizedDescription)
        }
    }
}
