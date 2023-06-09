//
//  Assembler.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

class Assembler {
    
    static func AuthenticationView(router: Router) -> AuthenticationViewController {
        return AuthenticationViewController(router: router)
    }
    
    static func HomeView(user: User, router: Router) -> HomePageViewController {
        return HomePageViewController(user: user, router: router)
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
    
    static func updateUserView(user: User, router: Router) -> UpdateUserView {
        let database = UpdateUserDatabase()
        let dataManager = UpdateUserDataManager(database: database)
        let usecase = UpdateUser(dataManager: dataManager)
        let presenter = UpdateUserPresenter(updateUser: usecase)
        let view = UpdateUserView(user: user, presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
}

extension Assembler {
    
    static func deleteTransaction(user: User, transaction: Transaction, router: Router) -> DeleteTransactionView {
        let database = DeleteTransactionDatabaseService()
        let dataManager = DeleteTransactionDataManager(database: database)
        let usecase = DeleteTransaction(dataManager: dataManager)
        let presenter = DeleteTransactionPresenter(deleteTransaction: usecase)
        let view = DeleteTransactionView(user: user, presenter: presenter, transaction: transaction)
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
    
    static func addTransactionView(user: User, router: Router, windowController: AddFloatingWindow, reloader: ToolBar) -> AddTransactionView {
        let database = AddTransactionDataDatabaseService()
        let dataManager = AddNewTransactionDataManager(database: database)
        let usecase = AddNewTransaction(dataManager: dataManager)
        let presenter = AddTransactionPresenter(AddNewTransaction: usecase)
        let view = AddTransactionView(user: user, presenter: presenter)
        presenter.view = view
        presenter.router = router
        presenter.windowController = windowController
        presenter.reloader = reloader
        return view
        
    }
    
    static func getRecentTranasctionsView(user: User, router: Router) -> RecentTransactionsView {
        let database = GetRecentTransactionDatabase()
        let dataManager = GetRecentTransactionDataManager(database: database)
        let usecase = GetRecentTransaction(dataManager: dataManager)
        let presenter = GetRecentTranasactionPresenter(getRecentTransaction: usecase)
        let view = RecentTransactionsView(user: user, presenter: presenter)
        presenter.router = router
        presenter.view = view
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
    
    static func updateTransactionView(user: User, transaction: Transaction, router: Router) -> UpdateTransactionView {
        let database = UpdateTranastionDatabaseServise()
        let dataManager = UpdateTransactionDataManager(database: database)
        let usecase = UpdateTransaction(dataManager: dataManager)
        let presenter = UpdateTransactionPresenter(updateTransaction: usecase)
        let view = UpdateTransactionView(user: user, presenter: presenter, transaction: transaction)
        presenter.view = view
        presenter.router = router
        return view
    }
    
    static func addMonthlyAnalysisTransaction(user: User, transaction: Transaction, router: Router) -> AddMonthlyAnalysisView {
        let database = AddMonthlyAnalysisTransactionDatabase()
        let dataManager = AddMonthlyAnalysisTransactionDataManager(database: database)
        let usecase = AddMonthlyAnalysisTransaction(dataManager: dataManager)
        let presenter = AddMonthlyAnalysisTransactionPresenter(AddMonthlyAnalysisTransaction: usecase)
        let view = AddMonthlyAnalysisView(user: user, presenter: presenter, transaction: transaction)
        presenter.view = view
        presenter.router = router
        return view
    }
    
    static func getMonthlySpent(user: User, router: Router) -> GetMonthlySpentView {
        let database = GetMonthlySpentDatabase()
        let databaseManager = GetMonthlySpentDataManager(database: database)
        let usecase = GetMonthlySpent(dataManager: databaseManager)
        let presenter = GetMonthlySpentPresenter(getMonthlySpent: usecase)
        let view = GetMonthlySpentView(presenter: presenter, user: user)
        presenter.view = view
        presenter.routher = router
        return view
    }
    
    static func getMonthlyIncome(user: User, router: Router) -> GetMonthlyIncomeView {
        let database = GetMonthlyIncomeDatabase()
        let dataManager = GetMonthlyIncomeDataManager(database: database)
        let usecase = GetMonthlyIncome(dataManager: dataManager)
        let presenter = GetMonthlyIncomePresenter(getMonthlyIncome: usecase)
        let view = GetMonthlyIncomeView(presenter: presenter, user: user)
        presenter.view = view
        presenter.routher = router
        return view
    }
    
    static func getMonthlyBalance(user: User, router: Router) -> GetMonthlyBalanceView {
        let database = GetMonthlyBalanceDatabase()
        let dataManager = GetMonthlyBalanceDataManager(database: database)
        let usecase = GetMonthlyBalance(dataManager: dataManager)
        let presenter = GetMonthlyBalancePresenter(getMonthlyBalance: usecase)
        let view = GetMonthlyBalanceView(presenter: presenter, user: user)
        presenter.view = view
        presenter.router = router
        return view
    }
}


//------------------------- Budget Assembler --------------------------
extension Assembler {
    
    static func addBudget(user: User, router: Router) -> AddBudgetView {
        let database = AddBudgetDatabaseService()
        let dataManager = AddBudgetDataManager(database: database)
        let usecase = AddBudget(dataManager: dataManager)
        let presenter = AddBudgetPresenter(addBudget: usecase)
        let view = AddBudgetView(user: user, presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
    
    static func getBudget(user: User, router: Router) -> GetBudgetView {
        let database = GetBudgetDatabase()
        let dataManager = GetBudgetDataManager(database: database)
        let usecase = GetBudget(dataManager: dataManager)
        let presenter = GetBudgetPresenter(getBudget: usecase)
        let view = GetBudgetView(presenter: presenter, user: user)
        presenter.router = router
        presenter.view = view
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
