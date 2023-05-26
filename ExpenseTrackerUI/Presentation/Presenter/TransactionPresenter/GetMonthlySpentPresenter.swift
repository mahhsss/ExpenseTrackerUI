//
//  GetMonthlySpentPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import ExpenseTrackerBackend

class GetMonthlySpentPresenter {
    
    weak var view: GetMonthlySpentViewContract?
    weak var routher: Router?
    var getMonthlySpent: GetMonthlySpent
    
    public init(getMonthlySpent: GetMonthlySpent) {
        self.getMonthlySpent = getMonthlySpent
    }
}

extension GetMonthlySpentPresenter: GetMonthlySpentPresenterContract {
    
    func viewLoadMonthlySpent(user: User, month: String) {
        let request = GetMonthlySpentRequest(userId: user.userId, month: month)
        self.getMonthlySpent.execute(request: request) { response in
            self.view?.load(success: response)
        } onFailure: { error in
            self.view?.failure(error: error)
        }
    }
}
