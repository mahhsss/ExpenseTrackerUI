//
//  GetTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetAllTransactionView: NSView {
    
    var presenter: GetAllTranasctionPresenterContract
    var user: User
    var transactions: [Transaction] = []
    var transactionView: AllTransactionView!
    let transactionLable = CustomText.customStringLabel(label: "Transactions", fontSize: 25, fontColor: .white, fontStyle: "Trap-Medium")
    
    init(user: User, presenter: GetAllTranasctionPresenterContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
        customizeTransactionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getTransaction()
        }
    }
    
    func getTransaction() {
        presenter.viewLoadTransaction(user: user)
    }
    
    func customizeTransactionView() {
        
        transactionLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(transactionLable)
        
        NSLayoutConstraint.activate([
            transactionLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            transactionLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
        ])
    }
}


extension GetAllTransactionView: GetAllTransactionViewContract {
    
    func load(success: GetAllTransactionResponse) {
        
        transactions = success.transactions
        let scrollView = NSScrollView()
        let tableView = NSTableView()
        transactions = success.transactions
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .noBorder
        scrollView.scrollerKnobStyle = .light
//        scrollView.horizontalScrollElasticity = .none
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.wantsLayer = true
        scrollView.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.headerView = nil
//        tableView.selectionHighlightStyle = .none
        scrollView.documentView = tableView
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Transaction"))
        
        tableView.addTableColumn(column1)
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: transactionLable.bottomAnchor, constant: 5),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    func failure(error: GetAllTransactionError) {
        
        let transactionLable = CustomText.customStringLabel(label: "Transactions", fontSize: 22, fontColor: .white, fontStyle: "Trap-Medium")
        let noTransactionLable = CustomText.customStringLabel(label: "No transaction recorded", fontSize: 15, fontColor: NSColor.systemRed, fontStyle: "Trap-Medium")
        let addTransactionLable = CustomText.customHeaderStringLabel(label: "Add transaction to keep a track on your expendature and income", fontSize: 15, fontStyle: "Trap-Medium")
        let transactionStack = NSStackView(views: [noTransactionLable, addTransactionLable])
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
            transactionStack.centerYAnchor.constraint(equalTo: centerYAnchor),
//            transactionStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
//            transactionStack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    
}

extension GetAllTransactionView: NSTableViewDelegate, NSTableViewDataSource   {
    
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        guard let tableView = notification.object as? NSTableView else {
            return
        }
        let selectedRow = tableView.selectedRow
        transactionView.displayDetails(transaction: transactions[selectedRow])
    }
}
