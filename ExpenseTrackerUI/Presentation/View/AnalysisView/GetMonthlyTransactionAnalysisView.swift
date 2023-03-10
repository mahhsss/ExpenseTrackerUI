//
//  GetTransactionAnalysisView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

public class GetMonthlyTransactionAnalysisView: NSView {
     
    var presenter: GetMonthlyTranasctionAnalysisPresenterContract
    var user: User
    
    init(presenter: GetMonthlyTranasctionAnalysisPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getMonthlyTransactionAnalysis()
        }
    }
    
    func getMonthlyTransactionAnalysis() {
        print("Enter the date in yyyy-mm-dd formate")
        let startDate = String(readLine()!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let inputDate = dateFormatter.date(from: startDate)!
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let resultDate = calendar.date(byAdding: dateComponents, to: inputDate)!
        let nextMonth = dateFormatter.string(from: resultDate)
        
        presenter.viewLoadMonthyTransaction(user: user, startDate: startDate, endDate: nextMonth)
    }
}

extension GetMonthlyTransactionAnalysisView: GetMonthlyTransactionAnalysisViewContract {
    
    func load(success: GetTransactionAnalysisResponse) {
        print("\n\(success.transaction)\n")
        print("\n\(success.analysis)\n")
        print("\n\(success.totalExpense)\n")
    }
    
    func failure(error: GetTransactionAnalysisError) {
        print("\n\(error)\n")
    }
}
