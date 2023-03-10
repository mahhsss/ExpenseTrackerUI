//
//  GetMonthlyTransactionAnalysisPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation
import ExpenseTrackerBackend

public class GetMonthlyTransactionAnalysisPresenter {
    
    weak var view: GetMonthlyTransactionAnalysisViewContract?
    weak var router: Router?
    var getMonthlyTransactionAnalysis: GetTransactionAnalysis
    
    init(getMonthlyTransactionAnalysis: GetTransactionAnalysis) {
        self.getMonthlyTransactionAnalysis = getMonthlyTransactionAnalysis
    }
    
}

extension GetMonthlyTransactionAnalysisPresenter: GetMonthlyTranasctionAnalysisPresenterContract {
    
    func viewLoadMonthyTransaction(user: User, startDate: String) {
        var request = GetTransactionAnalysisRequest(user: user, month: startDate)
        self.getMonthlyTransactionAnalysis.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
}
