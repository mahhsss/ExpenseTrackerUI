//
//  GetYearlyTransactionAnalysisPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 13/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetYearlyTransactionAnalysisPresenter {
    
    weak var view: GetYearlyTransactionAnalysisViewContract?
    weak var router: Router?
    var getYearlyTransactionAnalysis: GetTransactionAnalysis
    
    init(getYearlyTransactionAnalysis: GetTransactionAnalysis) {
        self.getYearlyTransactionAnalysis = getYearlyTransactionAnalysis
    }
    
}

extension GetYearlyTransactionAnalysisPresenter: GetYearlyTransactionAnalysisPresenterContract {
   
    func viewLoadYearlyTransaction(user: User, startDate: String, endDate: String) {
        let request = GetTransactionAnalysisRequest(userId: user.userId, startDate: startDate, endDate: endDate)
        self.getYearlyTransactionAnalysis.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
        
    }
}
