//
//  GetMonthlyIncomeView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetMonthlyIncomeView: NSView {
    
    let incomeLabel = CustomText.customStringLabel(label: "Income", fontSize: 20, fontColor: NSColor.black, fontStyle: "Trap-Medium")
    var presenter: GetMonthlyIncomePresenterContract?
    var user: User
    var incomeValue: NSTextField?
    var currentIncome = 0
    
    public init(presenter: GetMonthlyIncomePresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
        configureIncomeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func currentIncomeUpdateAfterNewTransation(TransactionAmount: Int) {
        currentIncome += TransactionAmount
        incomeValue?.stringValue = String(currentIncome)
    }
    
    func currentIncomeAfterDeletingTransaction(TransactionAmount: Int) {
        currentIncome -= TransactionAmount
        incomeValue?.stringValue = String(currentIncome)
    }
    
    func configureIncomeView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        presenter?.viewLoadMonthlySpent(user: user, month: formattedStartDate)
        
        displayIncome(incomeAmount: currentIncome)
    }
}

extension GetMonthlyIncomeView: GetMonthlyIncomeViewContract {
    
    func load(success: GetMonthlyIncomeResponse) {
        
        currentIncome = success.income
        incomeValue?.stringValue = String(currentIncome)
    }
    
    func failure(error: GetMonthlyIncomeError) {
        incomeValue?.stringValue = "0"
    }
    
    func displayIncome(incomeAmount: Int) {
        
        incomeValue = CustomText.customStringLabel(label: String(incomeAmount), fontSize: 22, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        guard let incomeValue = incomeValue else { return }
        let incomeStack = NSStackView(views: [incomeLabel, incomeValue])
        
        self.wantsLayer = true
        incomeStack.wantsLayer = true
        incomeStack.translatesAutoresizingMaskIntoConstraints = false
        incomeStack.orientation = .vertical
        incomeStack.spacing = 15
        self.layer?.backgroundColor = #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1)
        self.layer?.cornerRadius = 20
        
        addSubview(incomeStack)
        
        NSLayoutConstraint.activate([
            
            incomeStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            incomeStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 6),
            incomeStack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.85),
            incomeStack.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
}
