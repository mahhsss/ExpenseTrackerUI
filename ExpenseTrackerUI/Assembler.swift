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

//------------------------- Transaction Assembler --------------------------
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
    
    static func getAllTransactionView(user: User, router: Router) -> GetAllTransactionView {
        let database = GetAllTransactionDatabase()
        let dataManager = GetAllTransactionDataManager(database: database)
        let usecase = GetAllTransaction(dataManager: dataManager)
        let presenter = GetAllTransactionPresenter(getAllTransaction: usecase)
        let view = GetAllTransactionView(user: user, presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
}


//------------------------- Category Assembler --------------------------
extension Assembler {
    
    static func categoryView(user: User, router: Router) -> CategoryView {
        return CategoryView(router: router, user: user)
    }
}

extension Assembler {
    
    static func getCategory(user: User, router: Router) -> GetCategoryView {
        let database = GetCategoryDatabaseService()
        let dataManager = GetCategoryDataManagerServise(database: database)
        let usecase = GetCategory(dataManager: dataManager)
        let presenter = GetCategoryPresenter(getCategory: usecase)
        let view = GetCategoryView(presenter: presenter, user: user)
        presenter.view = view
        presenter.router = router
        return view
    }
}

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


//------------------------- Analysis Assembler --------------------------
extension Assembler {
    
    static func getAnalysisView(user: User, router: Router) -> GetAnalysisView {
        return GetAnalysisView(router: router, user: user)
    }
}


extension Assembler {
    
    static func getMonthlyTransactionAnalysis(user: User, router: Router) -> GetMonthlyTransactionAnalysisView {
        let database = GetTransactionAnalysisDatabase()
        let dataManager = GetTransactionAnalysisDataManager(database: database)
        let usecase = GetTransactionAnalysis(dataManager: dataManager)
        let presenter = GetMonthlyTransactionAnalysisPresenter(getMonthlyTransactionAnalysis: usecase)
        let view = GetMonthlyTransactionAnalysisView(presenter: presenter, user: user)
        presenter.view = view
        presenter.router = router
        return view
    }
}

extension Assembler {
    
    static func getYearlyTransactionAnalysis(user: User, router: Router) -> GetYearlyTransactionAnalysisView {
        let database = GetTransactionAnalysisDatabase()
        let dataManager = GetTransactionAnalysisDataManager(database: database)
        let usecase = GetTransactionAnalysis(dataManager: dataManager)
        let presenter = GetYearlyTransactionAnalysisPresenter(getYearlyTransactionAnalysis: usecase)
        let view = GetYearlyTransactionAnalysisView(presenter: presenter, user: user)
        presenter.view = view
        presenter.router = router
        return view
    }
}

extension Assembler {
    
    static func getWeeklyTransactionAnalysis(user: User, router: Router) -> GetWeeklyTransactionAnalysisView {
        let database = GetTransactionAnalysisDatabase()
        let dataManager = GetTransactionAnalysisDataManager(database: database)
        let usecase = GetTransactionAnalysis(dataManager: dataManager)
        let presenter = GetWeeklyTransactionAnalysisPresenter(getWeeklyTransactionAnalysis: usecase)
        let view = GetWeeklyTransactionAnalysisView(presenter: presenter, user: user)
        presenter.view = view
        presenter.router = router
        return view
    }
}
