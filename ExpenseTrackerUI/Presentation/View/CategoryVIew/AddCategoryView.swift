//
//  GetCategoryView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 07/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddCategoryView: NSView {
    
    var user: User
    var presenter: AddCategoryPageContract
    public init(user: User, presenter: AddCategoryPageContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            addCategory()
        }
    }
    
    func addCategory() {
        let category = ExpendatureCategory(categoryId: 0, userId: 1, categoryname: "csGo")
        print("\n\n\(category.categoryname) \(category.userId) \(category.categoryId)\n\n")
        presenter.viewDidLoadExpense(user: user, category: category)
    }
}

extension AddCategoryView: AddCategoryViewContract {
   
    func load(sucess: AddCategoryResponse) {
        print("\n\(sucess.message)\n")
    }
    
    func failure(error: AddCategoryError) {
        print("\n\(error.error)")
    }
 
}
