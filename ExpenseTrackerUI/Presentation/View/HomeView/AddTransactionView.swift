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
    init(user: User, presenter: AddTransactionPageContract) {
        self.user = user
        self.presenter = presenter
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
        
        let categorys: [String] = ["Food", "Travel", "shoping"]
        print("\nEnter the Amount spent")
        let amount = Int(readLine()!)
        print("\nSelect the Category")
        var i = 1
        for category in categorys {
            print("\(i). \(category)")
            i += 1
        }
        var category: String = "Foodie"
        let categorychosen = Int(readLine()!)
        point: while true {
            switch categorychosen {
            case 1:
                category = categorys[0]
                break point
            case 2:
                category = categorys[1]
                break point
            case 3:
                category = categorys[2]
                break point
            default:
                print("Select valid option")
            }
        }
        let transaction = Transaction(transactionId: 0, userId: user.userId, amount: amount!, transactionType: .spending, currencyType: .cash, date: "22/07/2023", category: category, note: "Summa")
        presenter.viewDidLoadExpense(user: user, transaction: transaction)
        
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
