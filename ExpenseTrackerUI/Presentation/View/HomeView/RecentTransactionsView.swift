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
    let scrollView = NSScrollView()
    var tableView = NSTableView()
    var deleteTransactionView: DeleteTransactionView?
    weak var homeViewController: HomePageViewController?
    var transactionStack: NSStackView?
    var transactionLable: NSTextField?
    
    init(user: User, presenter: GetRecentTransactionPresenterContract) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    override func viewDidMoveToSuperview() {
        
        configureTransactionView()
        configureTransactionLable()
        tableViewConfiguration()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTransactionLable() {
        
        transactionLable = CustomText.customHeaderStringLabel(label: "Transactions", fontSize: 20, fontColor: .white, fontStyle: "Trap-SemiBold")
        if let transactionLable = transactionLable {
            transactionLable.translatesAutoresizingMaskIntoConstraints = false
            addSubview(transactionLable)
            NSLayoutConstraint.activate([
                transactionLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                transactionLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 52)
            ])
        }
    }
    
    func configureTransactionView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        self.presenter.viewLoadTransaction(user: user, month: formattedStartDate)
    }
    
    func insertNewTransaction(transaction: Transaction) {
        
        if transactions.isEmpty {
            transactionStack?.removeFromSuperview()
            tableView.beginUpdates()
            transactionStack?.removeFromSuperview()
            transactions.insert(transaction, at: 0)
            tableView.reloadData()
            tableView.endUpdates()
        }
        else {
            tableView.beginUpdates()
            transactions.insert(transaction, at: 0)
            let indexSet = IndexSet(integer: 0)
            tableView.insertRows(at: indexSet, withAnimation: .slideLeft)
            tableView.endUpdates()
        }
        
        
    }
}

extension RecentTransactionsView: GetRecentTransactionViewContract {
   
    func load(transaction: [Transaction]) {
        transactions = transaction
        tableView.reloadData()
    }
    
    func tableViewConfiguration() {
        
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
        tableView.rowHeight = 65
        tableView.allowsMultipleSelection = true
        tableView.headerView = nil
        tableView.selectionHighlightStyle = .none
        scrollView.documentView = tableView
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Transaction"))
        
        tableView.addTableColumn(column1)
        
        addSubview(scrollView)
        
        guard let transactionLable = transactionLable else {
            transactionLable = CustomText.customHeaderStringLabel(label: "Transactions", fontSize: 20, fontColor: .white, fontStyle: "Trap-SemiBold")
            return
        }
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: transactionLable.bottomAnchor, constant: 5),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, constant: -50),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    func failure(error: String) {
        
        let noTransactionLable = CustomText.customStringLabel(label: "No transaction recorded this month!", fontSize: 14, fontColor: NSColor.systemRed, fontStyle: "Trap-Medium")
        transactionStack = NSStackView(views: [noTransactionLable])
        transactionStack!.spacing = 30
        transactionStack!.translatesAutoresizingMaskIntoConstraints = false
        transactionStack!.orientation = .vertical
        
        addSubview(transactionStack!)
        
        NSLayoutConstraint.activate([
            transactionStack!.centerXAnchor.constraint(equalTo: centerXAnchor),
            transactionStack!.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
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
            if transactions[row].transactionType.rawValue == "Income" {
                cell.image.image = NSImage(named: "rupee")
            }
            else {
                cell.image.image = NSImage(named: transactions[row].category!)
            }
            cell.identifier = NSUserInterfaceItemIdentifier(rawValue: TransactionCellView.identifier)
            return cell
        }
        cell.amount.stringValue = formattedAmount!
        cell.date.stringValue = String(outputDateString)
        cell.mode.stringValue = transactions[row].currencyType.rawValue
        cell.type.stringValue = transactions[row].transactionType.rawValue
        if transactions[row].transactionType.rawValue == "Income" {
            cell.image.image = NSImage(named: "rupee")
        }
        else {
            cell.image.image = NSImage(named: transactions[row].category!)
        }
        return cell
    }
    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableView.RowActionEdge) -> [NSTableViewRowAction] {
        if edge == .leading {
            return [] }

        let deleteAction = NSTableViewRowAction(style: .destructive, title: "Delete") { _,_ in
            
            let logoutAlert = NSAlert()
            logoutAlert.messageText = "Are you sure you want to delete?"
            logoutAlert.addButton(withTitle: "Yes")
            logoutAlert.addButton(withTitle: "No")
            logoutAlert.icon = NSImage(named: "warning")
            let response = logoutAlert.runModal()
            if response == .alertFirstButtonReturn {
                self.homeViewController?.afterTransactionDeletion(transactions: self.transactions, index: row)
                tableView.removeRows(at: IndexSet(integer: row), withAnimation: .effectFade)
                self.deleteTransactionView = Assembler.deleteTransaction(transactionId: self.transactions[row].transactionId)
                self.transactions.remove(at: row)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    tableView.reloadData()
                    if self.transactions.isEmpty {
                        self.failure(error: "no transactions left")
                    }
                }
            }
            else if response == .alertSecondButtonReturn {
                return
            }
        }
        
        deleteAction.backgroundColor = .systemRed
    
        return [deleteAction]
    }
}


class TransactionCellView: NSTableCellView {
    
    static var identifier = "transactions"
    var image = NSImageView()
    var transactionStack: NSStackView?
    var amount = CustomText.customStringLabel(label: "", fontSize: 15, fontColor: .white, fontStyle: "Trap-Medium")
    var date = CustomText.customStringLabel(label: "", fontSize: 15, fontColor: .white, fontStyle: "Trap-Medium")
    var mode = CustomText.customStringLabel(label: "", fontSize: 13, fontColor: .white, fontStyle: "Trap-Medium")
    var type = CustomText.customStringLabel(label: "", fontSize: 13, fontColor: .white, fontStyle: "Trap-Medium")
    
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
        transactionStack = NSStackView(views: [leftStack, rightStack])
        
        leftStack.orientation = .vertical
        rightStack.orientation = .vertical
        leftStack.spacing = 10
        rightStack.spacing = 10
        transactionStack?.orientation = .horizontal
        transactionStack?.distribution = .fillEqually
        image.imageScaling = .scaleProportionallyUpOrDown
        image.translatesAutoresizingMaskIntoConstraints = false
        image.wantsLayer = true
        transactionStack?.translatesAutoresizingMaskIntoConstraints = false
        transactionStack?.wantsLayer = true
        
        if let transactionStack = transactionStack {
            addSubview(image)
            addSubview(transactionStack)
            
            NSLayoutConstraint.activate([
                transactionStack.centerYAnchor.constraint(equalTo: centerYAnchor),
                transactionStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
                transactionStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80),
                transactionStack.heightAnchor.constraint(equalTo: heightAnchor),
                image.rightAnchor.constraint(equalTo: transactionStack.leftAnchor, constant: 7),
                image.centerYAnchor.constraint(equalTo: centerYAnchor),
                image.heightAnchor.constraint(equalTo: heightAnchor, constant: -38),
                image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
            ])
        }
        
        
        
    }
}
