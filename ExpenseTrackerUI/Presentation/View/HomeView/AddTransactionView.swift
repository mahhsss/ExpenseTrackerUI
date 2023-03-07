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
    var router: Router?
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
        
        var categorys: [ExpendatureCategory] = []
        if categorys.isEmpty {
            router?.getCategory(user: self.user)
            let getCategory = GetCategoryView(router: router!, user: user)
            categorys = getCategory.showCategory()
            if categorys.isEmpty {
                print("category is empty")
            }
        }
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
            categorychoice = categorys[categorychosen!].categoryname
            transaction = Transaction(transactionId: 0, userId: user.userId, amount: amount!, transactionType: transationType, currencyType: .cash, date: "22/07/2023", category: categorychoice!, note: "Summa")
        }
        else {
            transaction = Transaction(transactionId: 0, userId: user.userId, amount: amount!, transactionType: transationType, currencyType: .cash, date: "22/07/2023", note: "Summa")
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
