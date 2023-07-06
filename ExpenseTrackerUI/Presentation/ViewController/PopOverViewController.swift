//
//  PopOverViewController.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 04/07/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit


class PopoverContentViewController: NSViewController {
    
    var user: User
    weak var router: LogOutRouterContract?
    weak var homePageViewController: HomePageViewController?
    
    init(user: User, router: LogOutRouterContract, homePageViewController: HomePageViewController) {
        self.user = user
        self.router = router
        self.homePageViewController = homePageViewController
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
            
        }
        else if response == .alertSecondButtonReturn {
            return
        }
    }
}
