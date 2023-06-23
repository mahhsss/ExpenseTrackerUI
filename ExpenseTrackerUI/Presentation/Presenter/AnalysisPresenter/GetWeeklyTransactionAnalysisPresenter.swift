//
//  GetWeeklyTransactionAnalysisPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 13/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetWeeklyTransactionAnalysisPresenter {
    
    weak var view: GetWeeklyTransactionAnalysisViewContract?
    var getWeeklyTransactionAnalysis: GetTransactionAnalysis
   
    init(getWeeklyTransactionAnalysis: GetTransactionAnalysis) {
        self.getWeeklyTransactionAnalysis = getWeeklyTransactionAnalysis
    }
}

extension GetWeeklyTransactionAnalysisPresenter: GetWeeklyTransactionAnalysisPresenterContract {
    
    func viewLoadWeeklyTransaction(user: ExpenseTrackerBackend.User, startDate: String, endDate: String) {
        let request = GetTransactionAnalysisRequest(userId: user.userId, startDate: startDate, endDate: endDate)
        self.getWeeklyTransactionAnalysis.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
}
