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
    var user: User
    
    init(router: Router, user: User) {
        self.router = router
        self.user = user
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        if superview != nil {
            action()
        }
    }
    
    func action() {
        point: while true {
            print("\nChoose your option:")
            print("\n1. getCategory \n2.addCategory")
            let choice = Int(readLine()!)
            switch choice {
            case 1:
                break point
            case 2:
                router.addCategory(user: user)
                break point
            default:
                print("Enter valid key")
            }
        }
    }
    
   
    
    
}
//
//extension GetCategoryView: GetCategoryViewContract {
//   
//    func showCategory() -> [ExpendatureCategory] {
//        getCategory(user: user)
//        guard let category = category else {
//            return []
//        }
//        return category
//    }
//    
//    func getCategory(user: User) {
//        
//        presenter?.viewLoad(user: user)
//    }
//    
//    func load(success: GetCategoryResponse) {
//        
//        var categories: [ExpendatureCategory] = success.category
//        for item in categories {
//            self.category?.append(item)
//        }
//        print("\n Categories Added in GetCategory class\n")
//    }
//    
//    func failure(error: GetCategoryError) {
//        print("\n\(error.error)\n")
//    }
//}
