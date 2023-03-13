//
//  GetWeeklyTransactionAnalysisView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 13/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetWeeklyTransactionAnalysisView: NSView {
    
    var presenter: GetWeeklyTransactionAnalysisPresenterContract
    var user: User
    
    init(presenter: GetWeeklyTransactionAnalysisPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getWeeklyTransactionAnalysis()
        }
    }
    
    func getWeeklyTransactionAnalysis() {
        print("Enter the date in yyyy-mm-dd formate")
        let startDate = String(readLine()!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        var date = dateFormatter.date(from: startDate)
        let addTimeInterval = (7 * 24 * 60 * 60)
        let currentDate = date!.addingTimeInterval(TimeInterval(addTimeInterval))
        let nextWeek = dateFormatter.string(from: currentDate)
        presenter.viewLoadWeeklyTransaction(user: user, startDate: startDate, endDate: nextWeek)
    }
}

extension GetWeeklyTransactionAnalysisView: GetWeeklyTransactionAnalysisViewContract {
    
    func load(success: ExpenseTrackerBackend.GetTransactionAnalysisResponse) {
        print("\n\(success.transaction)\n")
        print("\n\(success.analysis)\n")
        print("\n\(success.totalExpense)\n")
    }
    
    func failure(error: ExpenseTrackerBackend.GetTransactionAnalysisError) {
        print("\n\(error.error)")
    }
}
