//
//  Router.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class Router: AddUserRouterContract {
    func selected() {
        print("Process Completed")
    }
    
    
    var window: NSWindow
    init(window: NSWindow) {
        self.window = window
    }
    
    func userSignUp() {
        print("Choose your option")
        print("1. SignUp \n0. Go Back")
        let choice = Int(readLine()!)
        if choice == 1 {
           
            print("Enter Name")
            let name = readLine()!
            print("Enter Email Id")
            let emailId = readLine()!
            print("Enter Password")
            let password = readLine()!
            let user = User(userId: 0, name: name, emailId: emailId, password: password)
            self.window.contentView = Assembler.addUserView(user: user, router: self)
        }
        else {
            return
        }
        
    }
    
    func userLogIn() {
        
    }
    
    
    func launch() {
        while true {
            print("Choose your option:")
            print("1. SignUp \n2. SignIn")
            var choice = Int(readLine()!)
            switch choice {
            case 1:
                self.userSignUp()
            case 2:
                self.userLogIn()
            default:
                print("Enter valid input")
            }
        }
    }
}
