//
//  RecentTransactionsView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 31/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend


class RecentTransactionsView: NSView {
    
    var presenter: GetRecentTransactionPresenterContract
    var user: User
    var transactions: [Transaction] = []
    
    init(user: User, presenter: GetRecentTransactionPresenterContract) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
        configureTransactionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTransactionView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = calendar.date(from: startDateComponents) else {
            fatalError("Failed to create the starting date.")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate)
        self.presenter.viewLoadTransaction(user: user, month: formattedStartDate)
    }
}

extension RecentTransactionsView: GetRecentTransactionViewContract {
    
    func load(success: GetRecentTransactionResponse) {
        
        let transactionLable = CustomText.customStringLabel(label: "Transactions", fontSize: 25, fontColor: .white, fontStyle: "Trap-Medium")
        let scrollView = NSScrollView()
        let tableView = NSTableView()
        transactions = success.transactions
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .noBorder
        scrollView.scrollerKnobStyle = .light
//        scrollView.horizontalScrollElasticity = .none
        transactionLable.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.wantsLayer = true
        scrollView.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.allowsMultipleSelection = true
        tableView.headerView = nil
        tableView.selectionHighlightStyle = .none
        scrollView.documentView = tableView
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Transaction"))
        
        tableView.addTableColumn(column1)
        
        addSubview(scrollView)
        addSubview(transactionLable)
        
        NSLayoutConstraint.activate([
            transactionLable.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            transactionLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: transactionLable.bottomAnchor, constant: 5),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    func failure(error: GetRecentTransactionError) {
        
        let transactionLable = CustomText.customStringLabel(label: "Transactions", fontSize: 25, fontColor: .white, fontStyle: "Trap-Medium")
        let noTransactionLable = CustomText.customStringLabel(label: "No transaction recorded this month!", fontSize: 15, fontColor: NSColor.systemRed, fontStyle: "Trap-Medium")
        var addTransactionButton = NSButton()
        let transactionStack = NSStackView(views: [noTransactionLable, addTransactionButton])
        addTransactionButton = customAddTransactionButton(addTransactionButton: addTransactionButton)
        transactionStack.spacing = 30
        
        transactionLable.translatesAutoresizingMaskIntoConstraints = false
        transactionStack.translatesAutoresizingMaskIntoConstraints = false
        transactionStack.orientation = .vertical
        
        addSubview(transactionStack)
        addSubview(transactionLable)
        
        NSLayoutConstraint.activate([
            transactionLable.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            transactionLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            transactionStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            transactionStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 45),
            transactionStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
            transactionStack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func customAddTransactionButton(addTransactionButton: NSButton) -> NSButton {
        
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.wantsLayer = true
        addTransactionButton.title = "Add Transaction"
//        loginButton.layer?.backgroundColor = #colorLiteral(red: 0.3159786165, green: 0.8165252209, blue: 1, alpha: 1)
        addTransactionButton.contentTintColor = .white
        addTransactionButton.isBordered = false
        addTransactionButton.alignment = .center
        addTransactionButton.target = self
        addTransactionButton.action = #selector(addTransaction(_:))
        addTransactionButton.focusRingType = .none
        addTransactionButton.font = .systemFont(ofSize: 15)
        addTransactionButton.layer?.borderWidth = 1
        addTransactionButton.layer?.borderColor = .white
        
        addTransactionButton.layer?.cornerRadius = 20
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTransactionButton.heightAnchor.constraint(equalToConstant: 45),
            addTransactionButton.widthAnchor.constraint(equalToConstant: 145),
        ])
        return addTransactionButton
    }
    
    @objc func addTransaction(_ sender: NSButton) {
        print("addTransaction")
    }
}

extension RecentTransactionsView: NSTableViewDelegate, NSTableViewDataSource   {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let inputDateString = transactions[row].date
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MMMM-yy"

        let inputDate = inputFormatter.date(from: inputDateString)
        let outputDateString = outputFormatter.string(from: inputDate!)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"

        let formattedAmount = numberFormatter.string(from: NSNumber(value: transactions[row].amount))
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: TransactionCellView.identifier) , owner: self) as? TransactionCellView else {
            let cell = TransactionCellView()
            cell.amount.stringValue = formattedAmount!
            cell.date.stringValue = String(outputDateString)
            cell.mode.stringValue = transactions[row].currencyType.rawValue
            cell.type.stringValue = transactions[row].transactionType.rawValue
            cell.image.image = NSImage(named: transactions[row].category!)
            if transactions[row].transactionType.rawValue == "Income" {
                cell.image.image = NSImage(named: "rupee")
            }
            return cell
        }
        cell.amount.stringValue = formattedAmount!
        cell.date.stringValue = String(outputDateString)
        cell.mode.stringValue = transactions[row].currencyType.rawValue
        cell.type.stringValue = transactions[row].transactionType.rawValue
        cell.image.image = NSImage(named: transactions[row].category!)
        if transactions[row].transactionType.rawValue == "Income" {
            cell.image.image = NSImage(named: "rupee")
        }
        return cell
    }
}


class TransactionCellView: NSTableCellView {
    
    static var identifier = "transactions"
    var image = NSImageView()
    var amount = CustomText.customStringLabel(label: "", fontSize: 25, fontColor: .white, fontStyle: "Trap-Medium")
    var date = CustomText.customStringLabel(label: "", fontSize: 20, fontColor: .white, fontStyle: "Trap-Medium")
    var mode = CustomText.customStringLabel(label: "", fontSize: 15, fontColor: .white, fontStyle: "Trap-Medium")
    var type = CustomText.customStringLabel(label: "", fontSize: 15, fontColor: .white, fontStyle: "Trap-Medium")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        customiseCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customiseCellView() {
        
        let leftStack = NSStackView(views: [amount, type])
        let rightStack = NSStackView(views: [date, mode])
        let transactionStack = NSStackView(views: [leftStack, rightStack])
        
        leftStack.orientation = .vertical
        rightStack.orientation = .vertical
        leftStack.spacing = 10
        rightStack.spacing = 10
        transactionStack.orientation = .horizontal
        transactionStack.distribution = .fillEqually
        image.imageScaling = .scaleProportionallyUpOrDown
        image.translatesAutoresizingMaskIntoConstraints = false
        image.wantsLayer = true
//        image.layer?.backgroundColor = .white
        transactionStack.translatesAutoresizingMaskIntoConstraints = false
        transactionStack.wantsLayer = true
        
        addSubview(image)
        addSubview(transactionStack)
        
        NSLayoutConstraint.activate([
            transactionStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            transactionStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            transactionStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80),
            transactionStack.heightAnchor.constraint(equalTo: heightAnchor),
            image.rightAnchor.constraint(equalTo: transactionStack.leftAnchor, constant: 7),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
        ])
    }
}
