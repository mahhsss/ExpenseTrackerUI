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
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    func configureBudgetView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        outterBar.translatesAutoresizingMaskIntoConstraints = false
        innerBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.wantsLayer = true
        outterBar.wantsLayer = true
        innerBar.wantsLayer = true
        outterBar.layer?.cornerRadius = 5
        outterBar.layer?.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        outterBar.layer?.borderWidth = 1
        outterBar.layer?.backgroundColor = .black
        innerBar.layer?.cornerRadius = 5
        innerBar.layer?.backgroundColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        
        progressBar.addSubview(outterBar)
        progressBar.addSubview(innerBar)
        
        presenter.viewLoadBudget(user: user, month: formattedStartDate)
    }
}

extension GetBudgetView: GetBudgetViewContract {
    
    func load(success: ExpenseTrackerBackend.GetBudgetResponse) {
        
        var restToSpent = success.budget - success.spent
        if restToSpent < 0 {
            restToSpent = 0
        }
        
        var budgetString = "\(success.spent) spent already. \(restToSpent) is left to reach the budget"
        var innerWidth = Float((success.spent)) / Float((success.budget))
        
        if Float((success.spent)) == (Float(success.budget)) {
            innerBar.layer?.backgroundColor = NSColor.systemRed.cgColor
            innerWidth = 1
        }
        else if Float((success.spent)) > (Float(success.budget)) {
            innerBar.layer?.backgroundColor = NSColor.systemRed.cgColor
            innerWidth = 1
            budgetString = "\(success.spent) spent already. \(success.spent - success.budget) spent beyond the budget"
        }
        else if  Float((success.spent)) > (Float(success.budget) / 2) {
            innerBar.layer?.backgroundColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
        }
        
        let budgetLabel = CustomText.customHeaderStringLabel(label: "Monthly budget", fontSize: 18, fontColor: .white, fontStyle: "Trap-SemiBold")
        let thisMonthBudgetText = CustomText.customStringLabel(label: "This month budget is \(success.budget)", fontSize: 15, fontColor: .systemBlue, fontStyle: "Trap-Medium")
        let balanceBudgetText =  CustomText.customStringLabel(label: budgetString, fontSize: 15, fontStyle: "Trap-Medium")
        let budgetStack = NSStackView(views: [thisMonthBudgetText, progressBar, balanceBudgetText])
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetStack.translatesAutoresizingMaskIntoConstraints = false
        budgetStack.wantsLayer = true
        budgetStack.orientation = .vertical
        budgetStack.alignment = .centerX
        budgetStack.spacing = 35
        
        addSubview(budgetLabel)
        addSubview(budgetStack)
        
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
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            budgetStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            budgetStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            budgetStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
            budgetStack.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func failure(error: ExpenseTrackerBackend.GetBudgetError) {
        
        let budgetLabel = CustomText.customHeaderStringLabel(label: "Monthly budget", fontSize: 18, fontColor: .white, fontStyle: "Trap-SemiBold")
        let noBudgetText = CustomText.customStringLabel(label: "Budget has not set for this month", fontSize: 13, fontColor: NSColor.systemRed, fontStyle: "Trap-Medium")
        let setBudgetText = CustomText.customHeaderStringLabel(label: "Set up a budget to help you stay on track with your expenses.", fontSize: 13, fontStyle: "Trap-Medium")
        let textStack = NSStackView(views: [noBudgetText, setBudgetText])
        
        textStack.orientation = .vertical
        textStack.alignment = .centerX
        textStack.spacing = 20
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        budgetLabel.wantsLayer = true
        textStack.wantsLayer = true
        
        addSubview(budgetLabel)
        addSubview(textStack)
        
        NSLayoutConstraint.activate([
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            textStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            textStack.centerYAnchor.constraint(equalTo: centerYAnchor),
//            textStack.heightAnchor.constraint(equalTo: heightAnchor),
//            textStack.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        
    }
}


