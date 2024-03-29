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
    
    var mainView: MainHomeView
    var transactionView = AllTransactionView()
    var leftMenuBar = LeftMenuBar()
    var toolBar: ToolBar?
    var profilePopOver = NSPopover()
    var floatingWindow: AddFloatingWindow?
    var addBudgetView: AddBudgetView?
    var currentPage = CurrentPage.homePage
    var user: User?
    weak var router: HomePageRouterContract?
    static var windowExist = false
    
    init(user: User, router: Router) {
        
        let spentView = Assembler.getMonthlySpent(user: user)
        let incomeView = Assembler.getMonthlyIncome(user: user)
        let balanceView = Assembler.getMonthlyBalance(user: user)
        let budgetView = Assembler.getBudget(user: user, router: router)
        let recentTransaction = Assembler.getRecentTranasctionsView(user: user)
        let allTransactions = Assembler.getAllTransactionView(user: user)
        mainView = MainHomeView()
        toolBar = ToolBar()
        mainView.spent = spentView
        mainView.income = incomeView
        mainView.balance = balanceView
        mainView.budgetView = budgetView
        mainView.recentTransactionsView = recentTransaction
        transactionView.transactionTableView = allTransactions
        transactionView.transactionTableView.transactionView = transactionView
        super.init(nibName: nil, bundle: nil)
        recentTransaction.homeViewController = self
        self.user = user
        self.router = router
        self.router?.homePageViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height))
        
    }
    
    override func viewWillLayout() {
    
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
        view.window?.toolbar = toolBar
        toolBar?.items[0].action = #selector(addTransactionButtonClicked(_:))
        toolBar?.items[1].action = #selector(setBudgetTransactionButtonClicked(_:))
        toolBar?.items[3].action = #selector(profileButtonClicked(_:))
        if let window = view.window {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.isMovableByWindowBackground = true
            window.title = "EXPENZO"
        }
//        view.window!.standardWindowButton(.closeButton)?.frame.origin.x = 8.0
//        view.window!.standardWindowButton(.closeButton)?.frame.origin.y = -2.0
//        view.window!.standardWindowButton(.miniaturizeButton)?.frame.origin.x = 30.0
//        view.window!.standardWindowButton(.miniaturizeButton)?.frame.origin.y = -2.0
//        view.window!.standardWindowButton(.zoomButton)?.frame.origin.x = 52.0
//        view.window!.standardWindowButton(.zoomButton)?.frame.origin.y = -2.0
        
//        if AppDelegate.isFullScreen {
//            toolBar.leftPoint.constant = 20
//        }
//        else {
//            toolBar.leftPoint.constant = 84
//        }
        
    }
    
    override func viewDidLoad() {
        
        

        
        let toolBarLine = NSView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        transactionView.translatesAutoresizingMaskIntoConstraints = false
        leftMenuBar.translatesAutoresizingMaskIntoConstraints = false
        toolBarLine.translatesAutoresizingMaskIntoConstraints = false
        toolBarLine.wantsLayer = true
        mainView.wantsLayer = true
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
        leftMenuBar.wantsLayer = true
        toolBarLine.layer?.backgroundColor = #colorLiteral(red: 0.5901135802, green: 0.5901135802, blue: 0.5901135802, alpha: 1)
        leftMenuBar.layer?.borderColor = #colorLiteral(red: 0.187238276, green: 0.187238276, blue: 0.187238276, alpha: 1)
        leftMenuBar.layer?.borderWidth = 1
        leftMenuBar.layer?.cornerRadius = 30
        leftMenuBar.layer?.backgroundColor = #colorLiteral(red: 0.07850127667, green: 0.07850127667, blue: 0.07850127667, alpha: 1)
        leftMenuBar.homeButton.action = #selector(buttonClicked(_:))
        leftMenuBar.homeButton.target = self
        leftMenuBar.transactionButton.action = #selector(buttonClicked(_:))
        leftMenuBar.transactionButton.target = self
        leftMenuBar.analysisButton.action = #selector(buttonClicked(_:))
        leftMenuBar.analysisButton.target = self
        
        
        mainView.wantsLayer = true
        mainView.isHidden = true
        mainView.layer?.backgroundColor = #colorLiteral(red: 0.07850127667, green: 0.07850127667, blue: 0.07850127667, alpha: 1)
        mainView.layer?.cornerRadius = 20
        
        transactionView.wantsLayer = true
        transactionView.isHidden = true
        transactionView.layer?.backgroundColor = #colorLiteral(red: 0.07850127667, green: 0.07850127667, blue: 0.07850127667, alpha: 1)
        transactionView.layer?.cornerRadius = 20
        
        view.addSubview(mainView)
        view.addSubview(transactionView)
        view.addSubview(leftMenuBar)
        
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
            transactionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            transactionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 27),
            transactionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.90),
            transactionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.91)
        ])
        
        displayView()
    }
    
    func displayView() {
        
        switch currentPage {
        case .homePage:
            displatMainView()
        case .transactionPage:
            displayTransactionView()
        case .analysisPage:
            displatMainView()
        }
    }
    
    
    @objc func buttonClicked(_ sender: NSButton) {
        
        if sender.tag == 1 {
            currentPage = .homePage
            displatMainView()
        }
        else if sender.tag == 2 {
            currentPage = .transactionPage
            displayTransactionView()
        }
        else {
            currentPage = .analysisPage
        }
        
    }
    
    func displayTransactionView() {
        
        for views in leftMenuBar.innerstack.views {
            let button = views as? NSButton
            button?.layer?.backgroundColor = .clear
            button?.image = button?.image?.tint(color: .white)
        }
        transactionView.isHidden = false
        mainView.isHidden = true
        leftMenuBar.transactionButton.image = leftMenuBar.transactionButton.image?.tint(color: #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1))
    }
    
    func displatMainView() {
        
        for views in leftMenuBar.innerstack.views {
            let button = views as? NSButton
            button?.layer?.backgroundColor = .clear
            button?.image = button?.image?.tint(color: .white)
        }
        transactionView.isHidden = true
        mainView.isHidden = false
        leftMenuBar.homeButton.image = leftMenuBar.homeButton.image?.tint(color: #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1))
    }
    
    func loadBudgetAfterUpdating(budget: Int) {
        
        mainView.budgetView.loadBudgetAfterUpdating(budget: budget, spent: mainView.spent.currentSpent)
    }
    
    func afterTransactionDeletion(transactions: [Transaction], index: Int) {
        
        transactionView.transactionTableView.reloadAfterDeletingTransaction(transactions: transactions, index: index)
        if transactions[index].transactionType == .spending {
            mainView.spent.currentSpentAfterDeletingTransaction(transactionAmount: transactions[index].amount)
            mainView.budgetView.loadBudgetAfterDeletingTransactionWithAnimation(spent: transactions[index].amount)
        }
        else {
            mainView.income.currentIncomeAfterDeletingTransaction(TransactionAmount: transactions[index].amount)
        }
        mainView.balance.currentBalanceAfterDeletingTransaction(thisMonthIncome: mainView.income.currentIncome, thisMonthSpent: mainView.spent.currentSpent)
    }
    
    func reloadAfterNewtransaction(transaction: Transaction) {
        
        floatingWindow?.close()
        //transactionView
        transactionView.transactionTableView.insertNewTransaction(transaction: transaction)
        
        //mainView
        mainView.recentTransactionsView.insertNewTransaction(transaction: transaction)
        if transaction.transactionType == .spending {
            mainView.budgetView.loadBudgetAfterNewTransactionWithAnimation(spent: transaction.amount)
            mainView.spent.currentSpentUpdateAfterNewTransaction(transationAmount: transaction.amount)
        }
        else {
            mainView.income.currentIncomeUpdateAfterNewTransation(TransactionAmount: transaction.amount)
        }
        
        mainView.balance.currentBalanceUpdateAfterNewTransaction(thisMonthIncome: mainView.income.currentIncome, thisMonthSpent: mainView.spent.currentSpent)
    }
    
    
    @objc func addTransactionButtonClicked(_ sender: NSButton) {
        if floatingWindow != nil {
            floatingWindow?.close()
        }
        HomePageViewController.windowExist = true
        if user != nil && router != nil {
            floatingWindow = AddFloatingWindow(user: user!, router: router!)
            floatingWindow?.showWindow(self)
            floatingWindow?.window?.hidesOnDeactivate = true
        }
    }
    
    @objc func setBudgetTransactionButtonClicked(_ sender: NSButton) {
        
        if user != nil && router != nil {
            addBudgetView = router?.updateBudget(user: user!, router: router!)
        }
    }
    
    func configurePopOver() {
        
        profilePopOver = NSPopover()
        profilePopOver.behavior = .transient
        profilePopOver.contentSize = NSSize(width: 200, height: 200)
        if let router = router {
            profilePopOver.contentViewController = PopoverContentViewController(user: user!, router: router)
        }
    }
    
    @objc func profileButtonClicked(_ sender: NSButton) {
        print("profile button clicked")
        configurePopOver()
        if profilePopOver.isShown {
            profilePopOver.close()
        } else {
            profilePopOver.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        }
    }
    
    func logout() {
        floatingWindow?.close()
        toolBar = nil
        router?.launch()
    }
    
}

enum CurrentPage: CaseIterable {
    
    case homePage
    case transactionPage
    case analysisPage
}
