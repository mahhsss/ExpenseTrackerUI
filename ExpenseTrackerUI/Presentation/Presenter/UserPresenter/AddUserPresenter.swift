//
//  AddUserPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import ExpenseTrackerBackend

class AddNewUserPresenter {
    
    weak var view: AddNewUserViewContract?
    weak var router: Router?
    var addNewUser: AddNewUser
    
    init(addNewUser: AddNewUser) {
        self.addNewUser = addNewUser
    }
    
}

extension AddNewUserPresenter: UserSignUpPagePresenterContract {
    
    func viewLoad(user: User) {
        let request = AddNewUserRequest(user: user)
        addNewUser.execute(request: request) { [weak self] response in
            self?.view?.load(sucess: response)
            self?.router?.launch()
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
            self?.router?.launch()
        }
    }
}
