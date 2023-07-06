//
//  AddTransactionFloatingWindow.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/06/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend


class AddFloatingWindow: NSWindowController {
    
    var user: User
    init(user: User, reloader: HomePageViewController) {
        self.user = user
        let window = NSWindow(contentRect: NSRect(x: 415, y: 200, width: 400, height: 300),
                              styleMask: [.titled, .closable, .fullSizeContentView],
                                backing: .buffered,
                                defer: false)
        super.init(window: window)
        window.titlebarSeparatorStyle = .none
        window.titlebarAppearsTransparent = true
        window.title = "Add Transaction"
        customiseFloatingWindow(user: user, reloader: reloader)
    }
    
    override func close() {
        HomePageViewController.windowExist = false
        window?.close()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customiseFloatingWindow(user: User, reloader: HomePageViewController) {
        
        window?.contentViewController = AddViewController(user: user, reloader: reloader)
    }
}
