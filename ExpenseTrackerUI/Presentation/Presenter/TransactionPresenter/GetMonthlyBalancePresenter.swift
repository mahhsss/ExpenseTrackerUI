//
//  GetMonthlyBalancePresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 27/05/23.
//

import Foundation
import ExpenseTrackerBackend

class GetMonthlyBalancePresenter {
    
    weak var view: GetMonthlyBalanceViewContract?
    weak var router: Router?
    var getMonthlyBalance: GetMonthlyBalance
    
    public init(getMonthlyBalance: GetMonthlyBalance) {
        self.getMonthlyBalance = getMonthlyBalance
    }
}

extension GetMonthlyBalancePresenter: GetMonthlyBalancePresenterContract {
    
    func viewLoadMonthlyBalance(user: ExpenseTrackerBackend.User, month: String) {
        let request = GetMonthlyBalanceRequest(userId: user.userId, month: month)
        getMonthlyBalance.execute(request: request) { response in
            self.view?.load(success: response)
        }onFailure: { error in
            self.view?.failure(error: error)
        }
    }
}
