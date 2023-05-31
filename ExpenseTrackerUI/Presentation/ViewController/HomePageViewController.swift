//
//  HomePageViewController.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class HomePageViewController: NSViewController {
    
    var router: Router
    var mainView: MainHomeView
    
    init(user: User, router: Router) {
        self.router = router
        let spentView = Assembler.getMonthlySpent(user: user, router: router)
        let incomeView = Assembler.getMonthlyIncome(user: user, router: router)
        let balanceView = Assembler.getMonthlyBalance(user: user, router: router)
        let budgetView = Assembler.getBudget(user: user, router: router)
        let recentTransaction = Assembler.getRecentTranasctionsView(user: user, router: router)
        mainView = MainHomeView()
        mainView.spent = spentView
        mainView.income = incomeView
        mainView.balance = balanceView
        mainView.budgetView = budgetView
        mainView.recentTransactionsView = recentTransaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height))
    }
    
    override func viewDidLoad() {
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.wantsLayer = true
        
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.90),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90)
        ])
        
    }
}
