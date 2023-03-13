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
    weak var router: Router?
    var getWeeklyTransactionAnalysis: GetTransactionAnalysis
   
    init(getWeeklyTransactionAnalysis: GetTransactionAnalysis) {
        self.getWeeklyTransactionAnalysis = getWeeklyTransactionAnalysis
    }
}

extension GetWeeklyTransactionAnalysisPresenter: GetWeeklyTransactionAnalysisPresenterContract {
    
    func viewLoadWeeklyTransaction(user: ExpenseTrackerBackend.User, startDate: String, endDate: String) {
        let request = GetTransactionAnalysisRequest(user: user, startDate: startDate, endDate: endDate)
        self.getWeeklyTransactionAnalysis.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
}
