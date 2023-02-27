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
    var addNewUser: AddNewUser
    weak var router: AddUserRouterContract?
    
    init(addNewUser: AddNewUser) {
        
        self.addNewUser = addNewUser
    }
}

extension AddNewUserPresenter: AddNewUserPresenterContract {
    
    func viewLoaded(user: User) {
        
        print("\nIn adduserPresenter\n\n")
        let request = AddNewUserRequest(user: user)
        addNewUser.execute(request: request, onSuccess: { [weak self] (response) in
            self?.result()
        }, onFailure: { [weak self] (error) in
            self?.failed()
        })
        
        if addNewUser.response != nil {
            view?.load()
        }
        else {
            view?.failure()
        }
        
    }
    
    func result() {
        view?.load()
    }
    
    func failed() {
        view?.failure()
    }
    
}
