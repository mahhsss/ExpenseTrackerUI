//
//  GetUserPresenter.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 01/03/23.
//

import Foundation
import ExpenseTrackerBackend

class GetUserPresenter {
    
    var view: GetUserViewontract?
    weak var router: Router?
    var user: User?
    var userLogin: UserLogin
    
    init(userLogin: UserLogin) {
        self.userLogin = userLogin
    }
}

extension GetUserPresenter: UserLoginPresenterContract {
  
    func viewDidLoad(emailId: String, password: String) {
        userLogin.run(request: UserLoginRequest(emailId: emailId, password: password)) { response in
            self.user = response.user
            self.view?.load(success: self.user!)
        } failure: { error in
            self.view?.failure(error: error)
            self.router?.userLogIn()
        }

    }
  
}
