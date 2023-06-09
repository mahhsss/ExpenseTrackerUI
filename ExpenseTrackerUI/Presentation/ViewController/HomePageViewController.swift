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
    var leftMenuBar = LeftMenuBar()
    var toolBar: ToolBar!
    
    init(user: User, router: Router) {
        self.router = router
        let spentView = Assembler.getMonthlySpent(user: user, router: router)
        let incomeView = Assembler.getMonthlyIncome(user: user, router: router)
        let balanceView = Assembler.getMonthlyBalance(user: user, router: router)
        let budgetView = Assembler.getBudget(user: user, router: router)
        let recentTransaction = Assembler.getRecentTranasctionsView(user: user, router: router)
        mainView = MainHomeView()
        toolBar = ToolBar()
        toolBar.user = user
        toolBar.router = router
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
    
    override func viewWillLayout() {
        
        view.window!.standardWindowButton(.closeButton)?.frame.origin.x = 8.0
        view.window!.standardWindowButton(.closeButton)?.frame.origin.y = -2.0
        view.window!.standardWindowButton(.miniaturizeButton)?.frame.origin.x = 30.0
        view.window!.standardWindowButton(.miniaturizeButton)?.frame.origin.y = -2.0
        view.window!.standardWindowButton(.zoomButton)?.frame.origin.x = 52.0
        view.window!.standardWindowButton(.zoomButton)?.frame.origin.y = -2.0
        
        if AppDelegate.isFullScreen {
            toolBar.leftPoint.constant = 20
        }
        else {
            toolBar.leftPoint.constant = 84
        }
        
    }
    
    override func viewDidLoad() {
        
        var toolBarLine = NSView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        leftMenuBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBarLine.translatesAutoresizingMaskIntoConstraints = false
        toolBarLine.wantsLayer = true
        toolBar.wantsLayer = true
        mainView.wantsLayer = true
        view.wantsLayer = true
        mainView.wantsLayer = true
        view.layer?.backgroundColor = .black
        mainView.layer?.backgroundColor = #colorLiteral(red: 0.1146241203, green: 0.1146241203, blue: 0.1146241203, alpha: 1)
        mainView.layer?.cornerRadius = 20
        leftMenuBar.wantsLayer = true
        toolBarLine.layer?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        leftMenuBar.layer?.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        leftMenuBar.layer?.borderWidth = 1
        leftMenuBar.layer?.cornerRadius = 30
        leftMenuBar.layer?.backgroundColor = #colorLiteral(red: 0.1146241203, green: 0.1146241203, blue: 0.1146241203, alpha: 1)
        
        view.addSubview(mainView)
        view.addSubview(leftMenuBar)
        view.addSubview(toolBar)
//        view.addSubview(toolBarLine)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 27),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.90),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.91)
        ])
        
        NSLayoutConstraint.activate([
            leftMenuBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            leftMenuBar.rightAnchor.constraint(equalTo: mainView.leftAnchor, constant: -23),
            leftMenuBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.92),
            leftMenuBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            toolBar.heightAnchor.constraint(equalToConstant: 50),
            toolBar.topAnchor.constraint(equalTo: view.topAnchor),
            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            toolBarLine.topAnchor.constraint(equalTo: toolBar.bottomAnchor),
//            toolBarLine.widthAnchor.constraint(equalTo: toolBar.widthAnchor),
//            toolBarLine.heightAnchor.constraint(equalToConstant: 0.27)
//        ])
    }
}
