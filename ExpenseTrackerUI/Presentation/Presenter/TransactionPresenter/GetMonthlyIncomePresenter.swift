//
//  GetMonthlyIncomePresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import ExpenseTrackerBackend

class GetMonthlyIncomePresenter  {
   
    weak var view: GetMonthlyIncomeViewContract?
    var getMonthlyIncome: GetMonthlyIncome
    public init(getMonthlyIncome: GetMonthlyIncome) {
        self.getMonthlyIncome = getMonthlyIncome
    }
}

extension GetMonthlyIncomePresenter: GetMonthlyIncomePresenterContract {
    
    func viewLoadMonthlySpent(user: ExpenseTrackerBackend.User, month: String) {
        let request = GetMonthlyIncomeRequest(userId: user.userId, month: month)
        self.getMonthlyIncome.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
    
}
