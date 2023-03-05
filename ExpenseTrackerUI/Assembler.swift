//
//  Assembler.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

class Assembler {
    static func AuthenticationView(router: Router) -> UserView {
        return UserView(router: router)
    }
}

//------------------------- Authentication Assembler ---------------------------
extension Assembler {
    
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
    
    static func userLoginView(router: Router) -> UserLoginPageView {
        let database = GetUserDatabase()
        let dataManager = UserLoginDataManagerServise(database: database)
        let useCase = UserLogin(dataManager: dataManager)
        let presenter = GetUserPresenter(userLogin: useCase)
        let view = UserLoginPageView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
}


extension Assembler {
    
    static func homePageView(router: Router, user: User) -> HomePageView {
        return HomePageView(router: router, user: user)
    }
}

//------------------------- AddTransaction Assembler --------------------------
extension Assembler {
    
    static func addExpenseView(user: User, router: Router) -> AddExpensePageView {
        let database = AddTransactionDataDatabaseService()
        let dataManager = AddNewTransactionDataManager(database: database)
        let usecase = AddNewTransaction(dataManager: dataManager)
        let presenter = AddExpensePresenter(AddNewTransaction: usecase)
        let view = AddExpensePageView(user: user, presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
        
    }
}
