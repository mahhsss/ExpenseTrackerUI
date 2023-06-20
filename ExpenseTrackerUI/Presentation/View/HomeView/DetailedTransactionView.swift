//
//  DetailedTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/06/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class DetailTransactionView: NSView {
    
    var detailsLable = CustomText.customStringLabel(label: "Transaction details", fontSize: 20, fontStyle: "Trap-SemiBold")
    var amount = CustomText.customStringLabel(label: "", fontSize: 13, fontStyle: "Trap-Medium")
    var category = CustomText.customStringLabel(label: "", fontSize: 13, fontStyle: "Trap-Medium")
    var transactionType = CustomText.customStringLabel(label: "", fontSize: 13, fontStyle: "Trap-Medium")
    var currencyType = CustomText.customStringLabel(label: "", fontSize: 13)
    var date = CustomText.customStringLabel(label: "", fontSize: 13)
    var note = CustomText.customStringLabel(label: "", fontSize: 13)
    let amountLable = CustomText.customStringLabel(label: "Amount :", fontSize: 15, fontStyle: "Trap-Medium")
    let categoryLable = CustomText.customStringLabel(label: "Category :", fontSize: 15, fontStyle: "Trap-Medium")
    let transactionLable = CustomText.customStringLabel(label: "Transaction type :", fontSize: 15, fontStyle: "Trap-Medium")
    let currencyLable = CustomText.customStringLabel(label: "CurrencyType :", fontSize: 15, fontStyle: "Trap-Medium")
    let dateLabel = CustomText.customStringLabel(label: "Date :", fontSize: 15, fontStyle: "Trap-Medium")
    let noteLable = CustomText.customStringLabel(label: "Note :", fontSize: 15, fontStyle: "Trap-Medium")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        customizeDetailTransactionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeDetailTransactionView() {
        
        detailsLable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsLable)
                
        NSLayoutConstraint.activate([
            detailsLable.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            detailsLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 52)
        ])
    }
    
    func displayTransactionDetails(transaction: Transaction) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE, MMM d, yyyy"

        let dateString = inputFormatter.date(from: transaction.date)
        let formattedDate = outputFormatter.string(from: dateString!)
        let formattedAmount = numberFormatter.string(from: NSNumber(value: transaction.amount))
        
        let amountStack = NSStackView(views: [amountLable, amount])
        let categoryStack = NSStackView(views: [categoryLable, category])
        let transactionstack = NSStackView(views: [transactionLable, transactionType])
        let currencyStack = NSStackView(views: [currencyLable, currencyType])
        let dateStack = NSStackView(views: [dateLabel, date])
        let noteStack = NSStackView(views: [noteLable, note])
        let stack = NSStackView(views: [amountStack, categoryStack, transactionstack, currencyStack, dateStack, noteStack])
        
        amount.stringValue = "" + formattedAmount!
        category.stringValue = "" + (transaction.category ?? "-")
        transactionType.stringValue = "" + transaction.transactionType.rawValue
        currencyType.stringValue = "" + transaction.currencyType.rawValue
        date.stringValue = "" + formattedDate
        note.stringValue = "" + (transaction.note ?? "-")
        
        amountStack.orientation = .vertical
        amountStack.spacing = 10
        amountStack.alignment = .left
        dateStack.orientation = .vertical
        dateStack.spacing = 10
        dateStack.alignment = .left
        categoryStack.orientation = .vertical
        categoryStack.spacing = 10
        categoryStack.alignment = .left
        transactionstack.orientation = .vertical
        transactionstack.spacing = 10
        transactionstack.alignment = .left
        currencyStack.orientation = .vertical
        currencyStack.spacing = 10
        currencyStack.alignment = .left
        dateStack.orientation = .vertical
        dateStack.spacing = 10
        dateStack.alignment = .left
        noteStack.orientation = .vertical
        noteStack.spacing = 10
        noteStack.alignment = .left
        
        stack.orientation = .vertical
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .left
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 65),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
