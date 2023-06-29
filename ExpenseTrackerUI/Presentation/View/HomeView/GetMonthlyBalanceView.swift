//
//  GetMonthlyBalanceView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 27/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend


class GetMonthlyBalanceView: NSView {
    
    let balanceLabel = CustomText.customStringLabel(label: "Balance", fontSize: 20, fontColor: NSColor.black, fontStyle: "Trap-Medium")
    var presenter: GetMonthlyBalancePresenterContract
    var user: User
    var currentBalance = 0
    var balanceValue: NSTextField?
    
    public init(presenter: GetMonthlyBalancePresenterContract, user: User) {
        
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
        configureBalanceView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBalanceView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        self.presenter.viewLoadMonthlyBalance(user: user, month: formattedStartDate)
    }
    
    func currentBalanceUpdateAfterNewTransaction(thisMonthIncome: Int, thisMonthSpent: Int) {
        currentBalance = thisMonthIncome - thisMonthSpent
        if thisMonthIncome - thisMonthSpent < 0 {
            balanceValue?.stringValue = "0"
        }
        else {
            balanceValue?.stringValue = String(currentBalance)
        }
        
    }
    
    func currentBalanceAfterDeletingTransaction(thisMonthIncome: Int, thisMonthSpent: Int) {
        
        currentBalance = thisMonthIncome - thisMonthSpent
        if thisMonthIncome - thisMonthSpent < 0 {
            balanceValue?.stringValue = "0"
        }
        else {
            balanceValue?.stringValue = String(currentBalance)
        }
        
    }
    
    func currentBalanceAfterDeletingIncomeTransaction(transactionAmount: Int) {
        currentBalance -= transactionAmount
//        if currentBalance < 0 {
//            currentBalance = 0
//        }
        balanceValue?.stringValue = String(currentBalance)
    }
    
    func currentBalanceAfterDeletingSpentTransaction(transactionAmount: Int) {
        currentBalance += transactionAmount
        balanceValue?.stringValue = String(currentBalance)
    }
}

extension GetMonthlyBalanceView: GetMonthlyBalanceViewContract {
    
    func load(success: GetMonthlyBalanceResponse) {
            
        currentBalance = success.balance
        displayBalance(balanceAmount: success.balance)
    }
    
    func failure(error: GetMonthlyBalanceError) {
        
        displayBalance(balanceAmount: 0)
    }
    
    func displayBalance(balanceAmount: Int) {
        
        
        balanceValue = CustomText.customStringLabel(label: String(balanceAmount), fontSize: 22, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        let balanceStack = NSStackView(views: [balanceLabel, balanceValue!])
        self.wantsLayer = true
        balanceStack.wantsLayer = true
        balanceStack.translatesAutoresizingMaskIntoConstraints = false
        balanceStack.orientation = .vertical
        balanceStack.spacing = 15
        self.layer?.backgroundColor = .init(red: 0.1, green: 2.5, blue: 5, alpha: 0.5)
        self.layer?.cornerRadius = 20
        
        addSubview(balanceStack)
        
        NSLayoutConstraint.activate([
            
            balanceStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            balanceStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 6),
            balanceStack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.85),
            balanceStack.widthAnchor.constraint(equalToConstant: 400),
//            self.heightAnchor.constraint(equalToConstant: 120),
//            self.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
}
