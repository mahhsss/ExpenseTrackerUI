//
//  GetUserPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 01/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetUserPresenter {
    
    weak var view: GetUserViewontract?
    weak var router: Router?
    var userLogin: UserLogin
    
    init(userLogin: UserLogin) {
        self.userLogin = userLogin
    }
}

extension GetUserPresenter: UserLoginPresenterContract {
  
    func viewDidLoad(emailId: String, password: String) {
        let request = UserLoginRequest(emailId: emailId, password: password)
        userLogin.execute(request: request) { [weak self] response in
            self?.view?.load(success: response.user)
            self?.router?.home(user: response.user)
//            self.router?.addTransaction(user: response.user)
        } onFailure: { [weak self] error in
            self?.view?.failure(error: error)
            self?.router?.launch()
        }
    }
  
}
