//
//  UserContract.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

protocol AddUserRouterContract: AnyObject {
    
    func selected()
}

protocol AddNewUserPresenterContract: AnyObject {
    
    func viewLoaded(user: User)
}

protocol AddNewUserViewContract: AnyObject {
    
    func load()
    func failure()
}
