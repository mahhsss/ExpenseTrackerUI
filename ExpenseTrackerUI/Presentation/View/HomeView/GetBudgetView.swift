//
//  File.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 29/05/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit


class GetBudgetView: NSView {
    
    var addBudgetButton = NSButton()
    var presenter: GetBudgetPresenterContract
    var user: User
    var outterBar = NSView()
    var innerBar = NSView()
    var progressBar = NSView()
    
    public init(presenter: GetBudgetPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
        configureBudgetView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBudgetView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = calendar.date(from: startDateComponents) else {
            fatalError("Failed to create the starting date.")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let formattedStartDate = dateFormatter.string(from: startDate)
        
        outterBar.translatesAutoresizingMaskIntoConstraints = false
        innerBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.wantsLayer = true
        outterBar.wantsLayer = true
        innerBar.wantsLayer = true
        outterBar.layer?.cornerRadius = 5
        outterBar.layer?.borderColor = .white
        outterBar.layer?.borderWidth = 2
        outterBar.layer?.backgroundColor = .black
        innerBar.layer?.cornerRadius = 5
        innerBar.layer?.backgroundColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        
        progressBar.addSubview(outterBar)
        progressBar.addSubview(innerBar)
        
        presenter.viewLoadBudget(user: user, month: formattedStartDate)
    }
    
    func customAddBudgetButton(addBudgetButton: NSButton) -> NSButton {
        
        addBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        addBudgetButton.wantsLayer = true
        addBudgetButton.title = "Add budget"
        addBudgetButton.contentTintColor = .white
        addBudgetButton.isBordered = false
        addBudgetButton.alignment = .center
        addBudgetButton.target = self
        addBudgetButton.action = #selector(addBudget(_:))
        addBudgetButton.focusRingType = .none
        addBudgetButton.font = .systemFont(ofSize: 15)
        addBudgetButton.layer?.borderWidth = 2
        addBudgetButton.layer?.borderColor = .white
        
        addBudgetButton.layer?.cornerRadius = 20
        addBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addBudgetButton.heightAnchor.constraint(equalToConstant: 45),
            addBudgetButton.widthAnchor.constraint(equalToConstant: 145),
        ])
        return addBudgetButton
    }
    
    @objc func addBudget(_ sender: NSButton) {
        print("addbudget")
    }
}

extension GetBudgetView: GetBudgetViewContract {
    
    func load(success: ExpenseTrackerBackend.GetBudgetResponse) {
        
        let budgetLabel = CustomText.customStringLabel(label: "Monthly budget", fontSize: 25, fontColor: .white, fontStyle: "Trap-SemiBold")
        let thisMonthBudgetText = CustomText.customStringLabel(label: "This Month budget is \(success.budget)", fontSize: 20, fontColor: .systemBlue, fontStyle: "Trap-Medium")
        let balanceBudgetText =  CustomText.customStringLabel(label: "\(success.spent) spent already. \(success.budget - success.spent) is left to reach the budget", fontSize: 19, fontColor: .white, fontStyle: "Trap-Medium")
        let budgetStack = NSStackView(views: [thisMonthBudgetText, progressBar, balanceBudgetText])
        var innerWidth = Float((success.spent)) / Float((success.budget))
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetStack.translatesAutoresizingMaskIntoConstraints = false
        budgetStack.wantsLayer = true
        budgetStack.orientation = .vertical
        budgetStack.alignment = .centerX
        budgetStack.spacing = 35
        
        addSubview(budgetLabel)
        addSubview(budgetStack)
        
        if  Float((success.spent)) > (Float(success.budget) / 2) {
            innerBar.layer?.backgroundColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
        }
        else if Float((success.spent)) == (Float(success.budget)) {
            innerBar.layer?.backgroundColor = NSColor.systemRed.cgColor
            innerWidth = 1
        }
        
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 25),
            outterBar.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            outterBar.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            outterBar.heightAnchor.constraint(equalToConstant: 25),
            outterBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80),
            innerBar.topAnchor.constraint(equalTo: outterBar.topAnchor),
            innerBar.leadingAnchor.constraint(equalTo: outterBar.leadingAnchor),
            innerBar.heightAnchor.constraint(equalTo: outterBar.heightAnchor),
            innerBar.widthAnchor.constraint(equalTo: outterBar.widthAnchor, multiplier: CGFloat(innerWidth)),
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            budgetStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            budgetStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            budgetStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
            budgetStack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func failure(error: ExpenseTrackerBackend.GetBudgetError) {
        
        let budgetLabel = CustomText.customStringLabel(label: "Monthly budget", fontSize: 25, fontColor: .white, fontStyle: "Trap-SemiBold")
        let noBudgetText = CustomText.customStringLabel(label: "Budget has not set for this month", fontSize: 15, fontColor: NSColor.red, fontStyle: "Trap-Medium")
        let setBudgetText = CustomText.customStringLabel(label: "Set up a budget to help you stay on track with your expenses.", fontSize: 15, fontColor: .white, fontStyle: "Trap-SemiBold")
        addBudgetButton = customAddBudgetButton(addBudgetButton: addBudgetButton)
        let textAndButtonStack = NSStackView(views: [noBudgetText, setBudgetText, addBudgetButton])
        
        textAndButtonStack.orientation = .vertical
        textAndButtonStack.alignment = .centerX
        textAndButtonStack.spacing = 20
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        textAndButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        budgetLabel.wantsLayer = true
        textAndButtonStack.wantsLayer = true
        
        addSubview(budgetLabel)
        addSubview(textAndButtonStack)
        
        NSLayoutConstraint.activate([
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            textAndButtonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            textAndButtonStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 115),
            textAndButtonStack.heightAnchor.constraint(equalTo: heightAnchor),
            textAndButtonStack.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        
    }
}