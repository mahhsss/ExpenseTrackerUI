//
//  AddBudget.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddBudgetView: NSView {
    
    var user: User
    var presenter: AddBudgetPresenterContract
    let numberFormatter = NumberFormatterr()
    init(user: User, presenter: AddBudgetPresenterContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSZeroRect)
        addBudget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBudget() {
        
        var alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "Set Budget to have an awareness on your spending"
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        textField.translatesAutoresizingMaskIntoConstraints =  false
        textField.isEditable = true
        textField.wantsLayer = true
        textField.isSelectable = true
//        textField.isBordered = false
        textField.focusRingType = .none
        textField.usesSingleLineMode = true
        textField.font = .systemFont(ofSize: 15)
        textField.wantsLayer = true
        textField.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
        textField.formatter = numberFormatter
        alert.accessoryView = textField
        alert.addButton(withTitle: "Yes")
        alert.addButton(withTitle: "No")
        alert.icon = NSImage(named: "rupee")
        let response = alert.runModal()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        
        if response == .alertFirstButtonReturn {
            if textField.stringValue.count > 0 {
                let budget = Budget(budget: Int(textField.stringValue)!, month: formattedStartDate)
                presenter.viewLoadBudget(user: user, budget: budget)
            }
            else {
                return
            }
        }
        else if response == .alertSecondButtonReturn {
            return
        }
        
    }
}


extension AddBudgetView: AddBudgetViewContract {
    
    func load(success: String) {
        print("\n\(success)\n")
    }
    
    func failure(error: String) {
        print("\n\(error)\n")
    }
}
