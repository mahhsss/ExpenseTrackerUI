//
//  UserView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class UserView: NSView {
    
    var router: Router
    var user: User?
    
    init(router: Router) {
        self.router = router
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            AuthenticationView()
        }
    }
    
    func AuthenticationView() {
        
        point: while true {
            print("Choose your option:")
            print("1. SignUp \n2. SignIn")
            let choice = Int(readLine()!)
            switch choice {
            case 1:
                router.userSignUp()
                break point
            case 2:
                router.userLogIn()
                break point
            default:
                print("Enter valid input")
                router.launch()
            }
        }
    }
}


