//
//  GetCategorysPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetCategoryPresenter {
    
    weak var view: GetCategoryViewContract?
    weak var router: Router?
    var user: User?
    var getCategory: GetCategory
    
    init(getCategory: GetCategory) {
        self.getCategory = getCategory
    }
}

extension GetCategoryPresenter: GetCategoryPresenterContract {
    
    func viewLoad(user: User) {
        let request = GetCategoryRequest(user: user)
        getCategory.execute(request: request) { response in
            self.view?.load(success: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
    }
}
