//
//  GetCategoryView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 07/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

public class GetCategoryView: NSView {
    
    var router: Router
    var category: [ExpendatureCategory]?
    var user: User
    var presenter: GetCategoryPresenterContract?
    
    init(router: Router, user: User, presenter: GetCategoryPresenterContract? = nil) {
        self.router = router
        self.user = user
        self.presenter = presenter
        super.init(frame: NSZeroRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getCategory(user: user)
        }
    }
    
    func showCategory() -> [ExpendatureCategory] {
        getCategory(user: user)
        guard let category = category else {
            return []
        }
        return category
    }
    
   
    
    
}

extension GetCategoryView: GetCategoryViewContract {
   
    func getCategory(user: User) {
        
        presenter?.viewLoad(user: user)
    }
    
    func load(success: GetCategoryResponse) {
        
        var categories: [ExpendatureCategory] = success.category
        for item in categories {
            self.category?.append(item)
        }
        print("\n Categories Added in GetCategory class\n")
    }
    
    func failure(error: GetCategoryError) {
        print("\n\(error.error)\n")
    }
}
