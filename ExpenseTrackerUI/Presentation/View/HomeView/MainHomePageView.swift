//
//  MainHomePageView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class MainHomeView: NSView {
    
    var expenseView = NSView()
    var recentTransactionsView: RecentTransactionsView!
    var budgetView: GetBudgetView!
    var spent: GetMonthlySpentView!
    var income: GetMonthlyIncomeView!
    var balance: GetMonthlyBalanceView!
 
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    override func viewDidMoveToSuperview() {
        
        configureExpenseViews()
        configureRecentTransactionsView()
        configureBudgetView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureExpenseViews() {
        
        let thisMonthText = CustomText.customHeaderStringLabel(label: "This month", fontSize: 20, fontColor: .white, fontStyle: "Trap-SemiBold")
        let expenseStack = NSStackView(views: [spent, income, balance])
        
        thisMonthText.translatesAutoresizingMaskIntoConstraints = false
        expenseStack.translatesAutoresizingMaskIntoConstraints = false
        expenseView.translatesAutoresizingMaskIntoConstraints = false
        expenseView.wantsLayer = true
        expenseView.layer?.borderWidth = 1
        expenseView.layer?.borderColor = #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1)
        expenseView.layer?.cornerRadius = 10
        expenseStack.orientation = .horizontal
        expenseStack.alignment = .lastBaseline
        expenseStack.distribution = .equalSpacing
        
        expenseView.addSubview(thisMonthText)
        expenseView.addSubview(expenseStack)
        addSubview(expenseView)
        
        NSLayoutConstraint.activate([
            
            expenseView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            expenseView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            expenseView.centerXAnchor.constraint(equalTo: centerXAnchor),
            expenseView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22),
            expenseView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.97),
            expenseStack.centerXAnchor.constraint(equalTo: expenseView.centerXAnchor),
            expenseStack.centerYAnchor.constraint(equalTo: expenseView.centerYAnchor,constant: 8),
            expenseStack.widthAnchor.constraint(equalTo: expenseView.widthAnchor, multiplier: 0.90),
            thisMonthText.topAnchor.constraint(equalTo: expenseView.topAnchor, constant: 20),
            thisMonthText.leftAnchor.constraint(equalTo: expenseView.leftAnchor, constant: 52)
        ])
        
        NSLayoutConstraint.activate([
            spent.heightAnchor.constraint(equalTo: expenseView.heightAnchor, multiplier: 0.50),
            spent.widthAnchor.constraint(equalToConstant: 280),
            income.heightAnchor.constraint(equalTo: expenseView.heightAnchor, multiplier: 0.50),
            income.widthAnchor.constraint(equalToConstant: 280),
            balance.heightAnchor.constraint(equalTo: expenseView.heightAnchor, multiplier: 0.50),
            balance.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureRecentTransactionsView() {
        
        recentTransactionsView.translatesAutoresizingMaskIntoConstraints = false
        recentTransactionsView.wantsLayer = true
        recentTransactionsView.layer?.backgroundColor = .black
        recentTransactionsView.layer?.cornerRadius = 10
        
        addSubview(recentTransactionsView)
        
        NSLayoutConstraint.activate([
            recentTransactionsView.topAnchor.constraint(equalTo: expenseView.bottomAnchor, constant: 15),
            recentTransactionsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            recentTransactionsView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40),
            recentTransactionsView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.48)
        ])
    }
    
    func configureBudgetView() {
        
        budgetView.translatesAutoresizingMaskIntoConstraints = false
        budgetView.wantsLayer = true
        budgetView.layer?.backgroundColor = .black
        budgetView.layer?.cornerRadius = 10
        
        addSubview(budgetView)
        
        NSLayoutConstraint.activate([
            budgetView.topAnchor.constraint(equalTo: expenseView.bottomAnchor, constant: 15),
            budgetView.rightAnchor.constraint(equalTo: expenseView.rightAnchor),
            budgetView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40),
            budgetView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.48)
        ])
    }
    
    func addTransactionWithAnimation(transaction: Transaction) {
        recentTransactionsView.insertNewTransaction(transation: transaction)
    }
    
}
