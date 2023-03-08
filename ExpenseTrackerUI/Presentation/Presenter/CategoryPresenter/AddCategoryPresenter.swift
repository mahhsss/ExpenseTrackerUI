//
//  AddCategoryPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 07/03/23.
//

import Foundation
import ExpenseTrackerBackend

public class AddCategoryPresenter {
   
    weak var view: AddCategoryViewContract?
    weak var router: Router?
    var addCategory: AddCategory
    
    init(addCategory: AddCategory) {
        self.addCategory = addCategory
    }
    
}

extension AddCategoryPresenter: AddCategoryPageContract {
    func viewDidLoadExpense(user: User, category: ExpendatureCategory) {
        let request = AddCategoryRequest(user: user, category: category)
        addCategory.execute(request: request) { response in
            self.view?.load(sucess: response)
            self.router?.addTransaction(user: user)
        } onFailure: { error in
            self.view?.failure(error: error)
            self.router?.addTransaction(user: user)
        }
        
    }
    
    
}
