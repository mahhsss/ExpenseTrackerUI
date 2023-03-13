//
//  GetYearlyAnalysisView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 13/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetYearlyTransactionAnalysisView: NSView {
    
    var presenter: GetYearlyTransactionAnalysisPresenterContract
    var user: User
    
    init(presenter: GetYearlyTransactionAnalysisPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getYearlyTransactionAnalysis()
        }
    }
    
    func getYearlyTransactionAnalysis() {
        
        print("Enter the date in yyyy-mm-dd formate")
        let startDate = String(readLine()!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let inputDate = dateFormatter.date(from: startDate)!
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 1
        let resultDate = calendar.date(byAdding: dateComponents, to: inputDate)!
        let nextYear = dateFormatter.string(from: resultDate)
        presenter.viewLoadYearlyTransaction(user: user, startDate: startDate, endDate: nextYear)
    }
}

extension GetYearlyTransactionAnalysisView: GetYearlyTransactionAnalysisViewContract {
    
    func load(success: GetTransactionAnalysisResponse) {
        print("\n\(success.transaction)")
        print("\n\(success.analysis)\n")
        print("\n\(success.totalExpense)\n")
    }
    
    func failure(error: GetTransactionAnalysisError) {
        print("\n\(error.error)")
    }
}
