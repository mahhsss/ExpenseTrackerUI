//
//  File.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 29/05/23.
//

import Foundation
import ExpenseTrackerBackend

public class GetBudgetPresenter {
    
    weak var view: GetBudgetViewContract?
    var getBudget: GetBudget
    
    public init(getBudget: GetBudget) {
        self.getBudget = getBudget
    }
    
}

extension GetBudgetPresenter: GetBudgetPresenterContract {
    
    func viewLoadBudget(user: ExpenseTrackerBackend.User, month: String) {
        
        let request = GetBudgetRequest(userId: user.userId, month: month)
        getBudget.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
}
