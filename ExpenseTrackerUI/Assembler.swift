//
//  Assembler.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

class Assembler {
    
    static func addUserView(user: User, router: AddUserRouterContract?) -> AddNewUserView {
        
        let database = AddUserDataDatabaseService()
        let dataManager = AddUserDatamanager(database: database)
        let useCase = AddNewUser(dataManager: dataManager)
        let presenter = AddNewUserPresenter(addNewUser: useCase)
        let view = AddNewUserView(presenter: presenter, user: user)
        view.presenter = presenter
        presenter.view = view
       
        return view
    }
}
