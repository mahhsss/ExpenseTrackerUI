//
//  AddViewController.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 08/06/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class AddViewController: NSViewController {
    
    var addTransactionView: AddTransactionView!
    var user: User
    var router: NewTransactionRouterContract?
    init(user: User, router: NewTransactionRouterContract) {
        self.user = user
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 700, height: NSScreen.main!.frame.height - 280))
        addTransactionView = Assembler.addTransactionView(user: user, router: router!)
    }
    
    override func viewDidLoad() {
        
        view.addSubview(addTransactionView)
        addTransactionView.translatesAutoresizingMaskIntoConstraints = false
        addTransactionView.wantsLayer = true
        view.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        addTransactionView.layer?.backgroundColor = .init(red: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 0.2)
        view.addSubview(addTransactionView)
        
        NSLayoutConstraint.activate([
            addTransactionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            addTransactionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addTransactionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTransactionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
