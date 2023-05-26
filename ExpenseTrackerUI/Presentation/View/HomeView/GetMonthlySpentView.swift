//
//  File.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend


public class GetMonthlySpentView: NSView {
    
    var presenter: GetMonthlySpentPresenterContract
    var user: User
    init(presenter: GetMonthlySpentPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GetMonthlySpentView: GetMonthlySpentViewContract {
    func load(success: ExpenseTrackerBackend.GetMonthlySpentResponse) {
        print("got the monthly spent")
    }
    
    func failure(error: ExpenseTrackerBackend.GetMonthlySpentError) {
        print("error while geting the monthly Spent \(error.error)")
    }
    
    
}
