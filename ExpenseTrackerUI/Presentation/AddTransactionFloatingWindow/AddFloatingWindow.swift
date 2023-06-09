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
    weak var router: Router?
    init(user: User, router: Router, reloader: ToolBar) {
        self.user = user
        self.router = router
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
                                styleMask: [.titled, .closable],
                                backing: .buffered,
                                defer: false)
        super.init(window: window)
        customiseFloatingWindow(user: user, router: router, windowController: self, reloader: reloader)
    }
    
    override func close() {
        window?.close()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customiseFloatingWindow(user: User, router: Router, windowController: AddFloatingWindow, reloader: ToolBar) {
        
        window?.contentViewController = AddViewController(user: user, router: router, windowController: self, reloader: reloader)
    }
}
