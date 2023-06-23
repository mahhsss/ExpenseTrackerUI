//
//  GetMonthlyTransactionAnalysisPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetMonthlyTransactionAnalysisPresenter {
    
    weak var view: GetMonthlyTransactionAnalysisViewContract?
    var getMonthlyTransactionAnalysis: GetTransactionAnalysis
    
    init(getMonthlyTransactionAnalysis: GetTransactionAnalysis) {
        self.getMonthlyTransactionAnalysis = getMonthlyTransactionAnalysis
    }
    
}

extension GetMonthlyTransactionAnalysisPresenter: GetMonthlyTranasctionAnalysisPresenterContract {
    
    func viewLoadMonthyTransaction(user: User, startDate: String, endDate: String) {
        let request = GetTransactionAnalysisRequest(userId: user.userId, startDate: startDate, endDate: endDate)
        self.getMonthlyTransactionAnalysis.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
}
