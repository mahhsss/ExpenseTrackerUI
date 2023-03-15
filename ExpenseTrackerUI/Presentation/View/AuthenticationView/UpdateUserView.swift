//
//  UpdateUserView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class UpdateUserView: NSView {
    
    var user: User
    var presenter: UpdateUserPresenterContract
    init(user: User, presenter: UpdateUserPresenterContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            updateUserView()
        }
    }
    
    func updateUserView() {
        presenter.viewLoad(user: user, column: "name", update: "mahi")
    }
}

extension UpdateUserView: UpdateUserViewContract {
    
    func load(success: UpdateUserResponse) {
        print("\n\(success.message)\n")
    }
    
    func failure(error: UpdateUserError) {
        print("\n\(error.error)")
    }
}
