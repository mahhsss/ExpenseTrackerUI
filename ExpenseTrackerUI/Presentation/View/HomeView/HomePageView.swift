//
//  HomePageView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 02/03/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class HomePageView: NSView {
    
    var router: Router
    var user: User
    init(router: Router, user: User) {
        self.router = router
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            userAction()
        }
    }
}

extension HomePageView {
    
    func userAction() {
        point: while true {
            print("\nChoose your option:")
            print("\n1. AddExpense \n2. AddIncome \n3. ViewTransactions \n4. ViewAnalysis \n5. UpdateUser")
            let choice = Int(readLine()!)
            switch choice {
            case 1:
                router.addExpense(user: user)
                break point
            case 2:
                router.addIncome(user: user)
                break point
            case 3:
                router.getAllTransaction(user: user)
                break point
            case 4:
                router.getAnalysis(user: user)
                break point
            case 5:
                router.updateUser(user: user)
                break point
            default:
                print("Enter valid key")
            }
        }
    }
    
    
}
