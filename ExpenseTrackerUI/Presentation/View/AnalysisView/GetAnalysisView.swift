//
//  GetAnalysisView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetAnalysisView: NSView {
    
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
//            action()
        }
    }
    
//    func action() {
//
//        point: while true {
//            print("choose the analysis you need")
//            print("\n1. Weekly Analysis \n2. Monthly Analysis \n3. Yearly Analysis")
//            let choice = Int(readLine()!)
//            switch choice {
//            case 1:
//                router.getWeeklyAnalysis(user: user)
//                break point
//            case 2:
//                router.getMonthlyAnalysis(user: user)
//                break point
//            case 3:
//                router.getYearlyAnalysis(user: user)
//                break point
//            default:
//                print("Enter valid key")
//            }
//        }
//    }
}
