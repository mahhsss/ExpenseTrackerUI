//
//  ToolBar .swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 05/06/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend

class ToolBar: NSView {
    
    var addTransactionButton = NSButton()
    var setBudgetTransaction = NSButton()
    var profileImageButton = NSButton()
    var leftPoint: NSLayoutConstraint!
    var profilePopOver = NSPopover()
    var user: User!
    var router: Router!
    var floatingWindow: AddFloatingWindow!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidMoveToSuperview() {
        customiseToolBar()
    }
    
    func customiseToolBar() {
        
        addTransactionButton = customAddButton(addButton: addTransactionButton)
        setBudgetTransaction = customAddButton(addButton: setBudgetTransaction)
        profileImageButton = customProfileButton(profileButton: profileImageButton)
        addTransactionButton.title = "Add transaction"
        setBudgetTransaction.title = "Set budget"
        profileImageButton.action = #selector(profileButtonClicked(_:))
        profileImageButton.target = self
        addTransactionButton.action = #selector(addTransactionButtonClicked(_:))
        addTransactionButton.target = self
        setBudgetTransaction.action = #selector(setBudgetTransactionButtonClicked(_:))
        setBudgetTransaction.target = self
        
        
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        setBudgetTransaction.translatesAutoresizingMaskIntoConstraints = false
        
        configurePopOver()
        
        addSubview(addTransactionButton)
        addSubview(setBudgetTransaction)
        addSubview(profileImageButton)
        
        leftPoint = addTransactionButton.leftAnchor.constraint(equalTo: leftAnchor)
        
        NSLayoutConstraint.activate([
            leftPoint,
            setBudgetTransaction.leftAnchor.constraint(equalTo: addTransactionButton.rightAnchor, constant: 6),
            setBudgetTransaction.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            addTransactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
    
    func customAddButton(addButton: NSButton) -> NSButton {
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.wantsLayer = true
        addButton.layer?.backgroundColor = .init(red: 0.2, green: 0.5, blue: 0.7, alpha: 0.5)
        addButton.contentTintColor = .white
        addButton.isBordered = false
        addButton.alignment = .center
        addButton.focusRingType = .none
        addButton.font = .systemFont(ofSize: 13)
        
        addButton.layer?.cornerRadius = 10
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.widthAnchor.constraint(equalToConstant: 135),
        ])
        return addButton
    }
    
    func customProfileButton(profileButton: NSButton) -> NSButton {
        
        profileButton.image = NSImage(named: "profile")
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.wantsLayer = true
        profileButton.focusRingType = .none
        profileButton.isBordered = false
        profileButton.image?.size = NSSize(width: 35, height: 35)
        
        NSLayoutConstraint.activate([
            profileButton.heightAnchor.constraint(equalToConstant: 35),
            profileButton.widthAnchor.constraint(equalToConstant: 35)
        ])
        return profileButton
    }
    
    func configurePopOver() {
        
        profilePopOver = NSPopover()
        profilePopOver.behavior = .transient
        profilePopOver.contentSize = NSSize(width: 200, height: 200)
        profilePopOver.contentViewController = PopoverContentViewController(user: user, router: router)
    
    }
    
    @objc func profileButtonClicked(_ sender: NSButton) {
        
        if profilePopOver.isShown {
            profilePopOver.close()
        } else {
            profilePopOver.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        }
    }
    
    @objc func addTransactionButtonClicked(_ sender: NSButton) {
        if floatingWindow != nil {
            floatingWindow.close()
        }
        floatingWindow = AddFloatingWindow(user: user, router: router, reloader: self)
        floatingWindow.showWindow(self)
        floatingWindow.window?.hidesOnDeactivate = true
    }
    
    @objc func setBudgetTransactionButtonClicked(_ sender: NSButton) {
        
        Assembler.addBudget(user: user, router: router)
    }
    
    func reload() {
        self.router.home(user: user)
    }
}

class PopoverContentViewController: NSViewController {
    
    var user: User
    weak var router: Router?
    
    init(user: User, router: Router) {
        self.user = user
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        view.wantsLayer = true
        view.layer?.backgroundColor = .init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        let logoutButton = custLogoutomButton(logoutButton: NSButton())
        let profileLable = CustomText.customStringLabel(label: "Profile", fontSize: 20, fontStyle: "Trap-SemiBold")
        let attributedString = NSMutableAttributedString(string: profileLable.stringValue)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
        profileLable.attributedStringValue = attributedString
        let userName = CustomText.customStringLabel(label: user.name, fontSize: 12, fontStyle: "Trap-Medium")
        let userMailId = CustomText.customStringLabel(label: user.emailId, fontSize: 12, fontStyle: "Trap-Medium")
        let popUpStack = NSStackView(views: [profileLable, userName, userMailId, logoutButton])
        popUpStack.orientation = .vertical
        popUpStack.spacing = 20
        view.addSubview(popUpStack)
        popUpStack.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.action = #selector(logout(_:))
        logoutButton.target = self
        
        
        NSLayoutConstraint.activate([
            popUpStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func custLogoutomButton(logoutButton: NSButton) -> NSButton {
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.wantsLayer = true
        logoutButton.layer?.backgroundColor = .init(red: 0.2, green: 0.5, blue: 0.7, alpha: 0.5)
        logoutButton.contentTintColor = .white
        logoutButton.isBordered = false
        logoutButton.alignment = .center
        logoutButton.focusRingType = .none
        logoutButton.font = .systemFont(ofSize: 13)
        logoutButton.title = "Logout"
        
        logoutButton.layer?.cornerRadius = 10
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 30),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        return logoutButton
    }
    
    @objc func logout(_ sender: NSButton) {
        
        let logoutAlert = NSAlert()
        logoutAlert.messageText = "Are you sure you want to logout?"
        logoutAlert.addButton(withTitle: "Yes")
        logoutAlert.addButton(withTitle: "No")
        logoutAlert.icon = NSImage(named: "profile")
        let response = logoutAlert.runModal()
        if response == .alertFirstButtonReturn {
            self.router?.launch()
        }
        else if response == .alertSecondButtonReturn {
            return
        } 
    }
}
