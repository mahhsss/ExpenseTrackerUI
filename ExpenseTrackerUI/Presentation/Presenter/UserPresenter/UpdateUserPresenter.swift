//
//  UpdateUserPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend


class UpdateUserPresenter {
    
    weak var view: UpdateUserViewContract?
    weak var router: Router?
    var updateUser: UpdateUser
    
    init(updateUser: UpdateUser) {
        self.updateUser = updateUser
    }
}

extension UpdateUserPresenter: UpdateUserPresenterContract {
    
    func viewLoad(user: User, column: String, update: Any) {
        let request = UpdateUserRequest(user: user, column: column, update: update)
        self.updateUser.execute(request: request) { response in
            self.view?.load(success: response)
        } onFailure: { error in
            self.view?.failure(error: error)
        }
    }
    
}
