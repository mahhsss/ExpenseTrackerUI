//
//  AllTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 12/06/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class AllTransactionView: NSView {
    
    var transactionTableView: GetAllTransactionView!
    var detailedTransactionView = DetailTransactionView()
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        configureTransactionTableView()
    }
    
    func displayDetails(transaction: Transaction) {
        
        detailedTransactionView.displayTransactionDetails(transaction: transaction)
    }
    
    func configureTransactionTableView() {
        
        transactionTableView.translatesAutoresizingMaskIntoConstraints = false
        transactionTableView.wantsLayer = true
        transactionTableView.layer?.backgroundColor = .black
        transactionTableView.layer?.cornerRadius = 10
        
        detailedTransactionView.translatesAutoresizingMaskIntoConstraints = false
        detailedTransactionView.wantsLayer = true
        detailedTransactionView.layer?.backgroundColor = .black
        detailedTransactionView.layer?.cornerRadius = 10
        
        addSubview(transactionTableView)
        addSubview(detailedTransactionView)
        
        NSLayoutConstraint.activate([
            transactionTableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            transactionTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            transactionTableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.95),
            transactionTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            transactionTableView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.48)
        ])
        
        configureDetailedTransactionLayout()
        
    }
    func configureDetailedTransactionLayout() {
        NSLayoutConstraint.activate([
            detailedTransactionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            detailedTransactionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            detailedTransactionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            detailedTransactionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.48)
        ])
    }
}
