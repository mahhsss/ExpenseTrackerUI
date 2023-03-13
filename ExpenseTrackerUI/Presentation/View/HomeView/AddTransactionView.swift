//
//  AddTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 02/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddTransactionPageView: NSView {
    
    var user: User
    var presenter: AddTransactionPageContract
    var transationType: TransactionType
    init(user: User, presenter: AddTransactionPageContract, transactionType: TransactionType) {
        self.user = user
        self.presenter = presenter
        self.transationType = transactionType
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            addTransactionView()
        }
    }
    
}

extension AddTransactionPageView {
    
    func addTransactionView() {
        
        
        var categorys: [String] = ["Food", "Travel", "shoping"]
        print("\nEnter the Amount spent")
        let amount = Int(readLine()!)
        print("\nSelect the Category")
        var i = 1
        for item in categorys {
            print("\(i). \(item)")
            i += 1
        }
        let transaction: Transaction?
        if transationType != .income {
            var categorychoice: String?
            let categorychosen = Int(readLine()!)
            point: while true {
                switch categorychosen {
                case 1:
                    categorychoice = categorys[0]
                    break point
                case 2:
                    categorychoice = categorys[1]
                    break point
                case 3:
                    categorychoice = categorys[2]
                    break point
                default:
                    print("Select valid option")
                }
            }
            transaction = Transaction(transactionId: 0, userId: user.userId, amount: amount!, transactionType: transationType, currencyType: .cash, date: "2024-01-06", note: "Summa")
        }
        else {
            transaction = Transaction(transactionId: 0, userId: user.userId, amount: amount!, transactionType: transationType, currencyType: .cash, date: "2024-01-06", note: "Summa")
        }
        
        
        presenter.viewDidLoadExpense(user: user, transaction: transaction!)
        
    }
    
}

extension AddTransactionPageView: AddNewTransactionContract {
    func load(success: AddNewTransactionResponse) {
        print("\n\(success.message)")
    }
    
    func failure(error: AddNewTransactionError) {
        print("\n\(error.error)")
    }
    
    
    
}
