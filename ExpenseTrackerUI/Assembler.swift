//
//  Assembler.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

class Assembler {
    
    static func addUserView(router: Router) -> UserSignUpPageView {
            
        let database = AddUserDataDatabaseService()
        let dataManager = AddUserDatamanager(database: database)
        let useCase = AddNewUser(dataManager: dataManager)
        let presenter = AddNewUserPresenter(addNewUser: useCase)
        let view = UserSignUpPageView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
    
    
}

