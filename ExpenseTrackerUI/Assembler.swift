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
        let dataManager = UserLoginDataManagerService(database: database)
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
    
    static func addTransactionView(user: User, router: Router, transactionType: TransactionType) -> AddTransactionPageView {
        let database = AddTransactionDataDatabaseService()
        let dataManager = AddNewTransactionDataManager(database: database)
        let usecase = AddNewTransaction(dataManager: dataManager)
        let presenter = AddTransactionPresenter(AddNewTransaction: usecase)
        let view = AddTransactionPageView(user: user, presenter: presenter, transactionType: transactionType)
        presenter.view = view
        presenter.router = router
        return view
        
    }
}


//------------------------- Category Assembler --------------------------
extension Assembler {
    
    static func categoryView(user: User, router: Router) -> GetCategoryView {
        return GetCategoryView(router: router, user: user)
    }
}

//extension Assembler {
//    
//    static func getCategory(user: User, router: Router) -> GetCategoryView {
//        let database = GetCategoryDatabaseServise()
//        let dataManager = GetCategoryDataManagerServise(database: database)
//        let usecase = GetCategory(dataManager: dataManager)
//        let presenter = GetCategoryPresenter(getCategory: usecase)
//        let view = GetCategoryView(router: router, user: user, presenter: presenter)
//        presenter.view = view
//        view.presenter = presenter
//        return view
//    }
//}

extension Assembler {
    
    static func addCategory(user: User, router: Router) -> AddCategoryView {
        let database = AddCategoryDatabaseService()
        let dataManager  = AddCategoryDatamanager(database: database)
        let usecase = AddCategory(dataManager: dataManager)
        let presenter = AddCategoryPresenter(addCategory: usecase)
        let view = AddCategoryView(user: user, presenter: presenter)
        presenter.view = view
        return view
    }
}
