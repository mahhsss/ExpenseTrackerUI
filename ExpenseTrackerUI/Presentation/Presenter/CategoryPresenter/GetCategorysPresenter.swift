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
    var getCategory: GetCategory
    
    init(getCategory: GetCategory) {
        self.getCategory = getCategory
    }
}

extension GetCategoryPresenter: GetCategoryPresenterContract {
    
    func viewLoad(user: User) {
        let request = GetCategoryRequest(userId: user.userId)
        getCategory.execute(request: request) { [weak self] response in
            self?.view?.load(success: response)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
        }
    }
}
