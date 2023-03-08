//
//  GetCategoryView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

public class GetCategoryView: NSView {
    
    var presenter: GetCategoryPresenterContract
    var user: User
    var category: [String] = []
    init(presenter: GetCategoryPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            getCategory()
        }
    }
    
    func getCategory() {
        presenter.viewLoad(user: user)
    }
}

extension GetCategoryView: GetCategoryViewContract {
    
    func load(success: GetCategoryResponse) {
        for item in success.category {
            self.category.append(item.categoryname)
            print(item.categoryname)
        }
       print("\n\(category)\n")
    }
    
    func failure(error: GetCategoryError) {
        print("\n\(error.error)\n")
    }
    
}
