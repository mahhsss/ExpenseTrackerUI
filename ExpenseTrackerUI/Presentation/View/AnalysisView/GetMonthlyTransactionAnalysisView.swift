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
        print("Enter the month in yyyy-mm-dd formate")
        var startDate = String(readLine()!)
        presenter.viewLoadMonthyTransaction(user: user, startDate: startDate)
    }
}

extension GetMonthlyTransactionAnalysisView: GetMonthlyTransactionAnalysisViewContract {
    
    func load(success: GetTransactionAnalysisResponse) {
        print("\n\(success.transaction)\n")
    }
    
    func failure(error: GetTransactionAnalysisError) {
        print("\n\(error)\n")
    }
}
