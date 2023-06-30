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
    var innerWidth: Float = 0
    var currentWidth: Float = 0
    var progressBar = NSView()
    var thisMonthBudget = 0
    var thisMonthSpent = 0
    var currentColor: NSColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
    var thisMonthBudgetText =  CustomText.customStringLabel(label: "", fontSize: 15, fontColor: .systemBlue, fontStyle: "Trap-Medium")
    var budgetLabel = CustomText.customHeaderStringLabel(label: "Monthly budget", fontSize: 18, fontColor: .white, fontStyle: "Trap-SemiBold")
    var balanceBudgetText = CustomText.customStringLabel(label: "", fontSize: 15, fontStyle: "Trap-Medium")
    var budgetStack: NSStackView?
    var textStack: NSStackView?
    var budgetString = ""
    var budgetInitialized = false

    
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
    
    func loadBudgetAfterUpdating(budget: Int, spent: Int) {
       
        if !budgetInitialized {
            
            textStack?.removeFromSuperview()
            thisMonthBudget = budget
            thisMonthSpent = spent
            var restToSpent = budget - spent
            if restToSpent < 0 {
                restToSpent = 0
            }
            
            budgetString = "\(thisMonthSpent) spent already. \(restToSpent) is left to reach the budget"
            innerWidth = Float((thisMonthSpent)) / Float((thisMonthBudget))
            
            if Float((thisMonthSpent)) == (Float(thisMonthBudget)) {
                innerBar.layer?.backgroundColor = NSColor.systemRed.cgColor
                innerWidth = 1
            }
            else if Float((thisMonthSpent)) > (Float(thisMonthBudget)) {
                innerBar.layer?.backgroundColor = NSColor.systemRed.cgColor
                innerWidth = 1
                budgetString = "\(thisMonthSpent) spent already. \(thisMonthSpent - thisMonthBudget) spent beyond the budget"
            }
            else if  Float((thisMonthSpent)) > (Float(thisMonthBudget) / 2) {
                innerBar.layer?.backgroundColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
            }
            
            thisMonthBudgetText = CustomText.customStringLabel(label: "This month budget is \(thisMonthBudget)", fontSize: 15, fontColor: .systemBlue, fontStyle: "Trap-Medium")
            balanceBudgetText =  CustomText.customStringLabel(label: budgetString, fontSize: 15, fontStyle: "Trap-Medium")
            budgetStack = NSStackView(views: [thisMonthBudgetText, progressBar, balanceBudgetText])
            
            budgetLabel.translatesAutoresizingMaskIntoConstraints = false
            budgetStack?.translatesAutoresizingMaskIntoConstraints = false
            budgetStack?.wantsLayer = true
            budgetStack?.orientation = .vertical
            budgetStack?.alignment = .centerX
            budgetStack?.spacing = 35
            
            addSubview(budgetLabel)
            if let budgetStack = budgetStack {
                addSubview(budgetStack)
                
                NSLayoutConstraint.activate([
                    budgetStack.centerXAnchor.constraint(equalTo: centerXAnchor),
                    budgetStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
                    budgetStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
                    budgetStack.widthAnchor.constraint(equalTo: widthAnchor)
                ])
            }
            
            let widthvalue = self.frame.width
            currentWidth = Float(widthvalue) * 0.80 * innerWidth
            
            innerBar.frame.size.width = widthvalue * 0.80 * CGFloat(innerWidth)
            
            NSLayoutConstraint.activate([
                progressBar.heightAnchor.constraint(equalToConstant: 25),
                outterBar.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
                outterBar.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
                outterBar.heightAnchor.constraint(equalToConstant: 25),
                outterBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80),
                innerBar.topAnchor.constraint(equalTo: outterBar.topAnchor),
                innerBar.leadingAnchor.constraint(equalTo: outterBar.leadingAnchor),
                innerBar.heightAnchor.constraint(equalTo: outterBar.heightAnchor),
    //            innerBar.widthAnchor.constraint(equalTo: outterBar.widthAnchor, multiplier: CGFloat(innerWidth)),
    //            innerBar.widthAnchor.constraint(equalToConstant: CGFloat((Float(widthvalue) * 0.80 * innerWidth))),
                budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52)
            ])
            budgetInitialized = true
        }
        else {
            
            thisMonthBudget = budget
            thisMonthSpent = spent
            thisMonthBudgetText.stringValue = "This month budget is \(thisMonthBudget)"
            var targetColor: NSColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
            let widthvalue = self.frame.width
            
            innerWidth = Float((thisMonthSpent)) / Float((thisMonthBudget))
            var targetWidth = Float(widthvalue) * 0.80 * innerWidth
            
            let restToSpent = thisMonthBudget - thisMonthSpent
            
            budgetString = "\(thisMonthSpent) spent already. \(restToSpent) is left to reach the budget"
            
            if Float((thisMonthSpent)) == (Float(thisMonthBudget)) {
                targetColor = NSColor.systemRed
                targetWidth = Float(self.frame.width * 0.80)
                innerWidth = 1
            }
            else if Float((thisMonthSpent)) > (Float(thisMonthBudget)) {
                
                targetColor = NSColor.systemRed
                targetWidth = Float(self.frame.width * 0.80)
                innerWidth = 1
                budgetString = "\(thisMonthSpent) spent already. \(thisMonthSpent - thisMonthBudget) spent beyond the budget"
            }
            else if  Float((thisMonthSpent)) > (Float(thisMonthBudget) / 2) {
                targetColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
            }
            
            
            let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
            widthAnimation.fromValue = currentWidth
            widthAnimation.toValue = targetWidth
            widthAnimation.duration = 1.0
            widthAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            colorAnimation.fromValue = currentColor
            colorAnimation.toValue = targetColor.cgColor
            colorAnimation.duration = 1.0
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [widthAnimation, colorAnimation]
            animationGroup.duration = 1.0
            
            innerBar.layer?.add(animationGroup, forKey: "widthAndColorAnimation")
            
            balanceBudgetText.stringValue = budgetString
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animationGroup.duration - 0.25) {
                self.innerBar.frame.size.width = CGFloat(targetWidth)
                self.innerBar.layer?.backgroundColor = targetColor.cgColor
                self.currentWidth = targetWidth
                self.currentColor = targetColor
            }
        }
        
        
    }
    
    func loadBudgetAfterNewTransactionWithAnimation(spent: Int) {
        
        thisMonthSpent += spent
        var targetColor: NSColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        let widthvalue = self.frame.width
        
        innerWidth = Float((thisMonthSpent)) / Float((thisMonthBudget))
        var targetWidth = Float(widthvalue) * 0.80 * innerWidth
        
        let restToSpent = thisMonthBudget - thisMonthSpent
        
        budgetString = "\(thisMonthSpent) spent already. \(restToSpent) is left to reach the budget"

        
        if Float((thisMonthSpent)) == (Float(thisMonthBudget)) {
            targetColor = NSColor.systemRed
            targetWidth = Float(self.frame.width * 0.80)
            innerWidth = 1
        }
        else if Float((thisMonthSpent)) > (Float(thisMonthBudget)) {
            
            let logoutAlert = NSAlert()
            logoutAlert.messageText = "\(thisMonthSpent - thisMonthBudget) spent beyond the budget"
            logoutAlert.addButton(withTitle: "Ok")
            logoutAlert.icon = NSImage(named: "warning")
            logoutAlert.runModal()
            targetColor = NSColor.systemRed
            targetWidth = Float(self.frame.width * 0.80)
            innerWidth = 1
            budgetString = "\(thisMonthSpent) spent already. \(thisMonthSpent - thisMonthBudget) spent beyond the budget"
        }
        else if  Float((thisMonthSpent)) > (Float(thisMonthBudget) / 2) {
            print("in orange")
            targetColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
        }
        
        
        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.fromValue = currentWidth
        widthAnimation.toValue = targetWidth
        widthAnimation.duration = 1.0
        widthAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = currentColor
        colorAnimation.toValue = targetColor.cgColor
        colorAnimation.duration = 1.0
        colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [widthAnimation, colorAnimation]
        animationGroup.duration = 1.0
        
        innerBar.layer?.add(animationGroup, forKey: "widthAndColorAnimation")
        
        balanceBudgetText.stringValue = budgetString
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationGroup.duration - 0.25) {
            self.innerBar.frame.size.width = CGFloat(targetWidth)
            self.innerBar.layer?.backgroundColor = targetColor.cgColor
            self.currentWidth = targetWidth
            self.currentColor = targetColor
        }
    }
    
    func loadBudgetAfterDeletingTransactionWithAnimation(spent: Int) {
        
        thisMonthSpent -= spent
        var targetColor: NSColor = .init(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        let widthvalue = self.frame.width
        
        innerWidth = Float((thisMonthSpent)) / Float((thisMonthBudget))
        var targetWidth = Float(widthvalue) * 0.80 * innerWidth
        
        let restToSpent = thisMonthBudget - thisMonthSpent
        
        budgetString = "\(thisMonthSpent) spent already. \(restToSpent) is left to reach the budget"

        
        if Float((thisMonthSpent)) == (Float(thisMonthBudget)) {
            targetColor = NSColor.systemRed
            targetWidth = Float(self.frame.width * 0.80)
            innerWidth = 1
        }
        else if Float((thisMonthSpent)) > (Float(thisMonthBudget)) {
            
            let logoutAlert = NSAlert()
            logoutAlert.messageText = "\(thisMonthSpent - thisMonthBudget) spent beyond the budget"
            logoutAlert.addButton(withTitle: "Ok")
            logoutAlert.icon = NSImage(named: "warning")
            let response = logoutAlert.runModal()
            targetColor = NSColor.systemRed
            targetWidth = Float(self.frame.width * 0.80)
            innerWidth = 1
            budgetString = "\(thisMonthSpent) spent already. \(thisMonthSpent - thisMonthBudget) spent beyond the budget"
        }
        else if  Float((thisMonthSpent)) > (Float(thisMonthBudget) / 2) {
            print("in orange")
            targetColor = #colorLiteral(red: 1, green: 0.4136213064, blue: 0.2176061869, alpha: 1)
        }
        
        
        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.fromValue = currentWidth
        widthAnimation.toValue = targetWidth
        widthAnimation.duration = 1.0
        widthAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = currentColor
        colorAnimation.toValue = targetColor.cgColor
        colorAnimation.duration = 1.0
        colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [widthAnimation, colorAnimation]
        animationGroup.duration = 1.0
        
        innerBar.layer?.add(animationGroup, forKey: "widthAndColorAnimation")
        
        balanceBudgetText.stringValue = budgetString
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationGroup.duration - 0.25) {
            self.innerBar.frame.size.width = CGFloat(targetWidth)
            self.innerBar.layer?.backgroundColor = targetColor.cgColor
            self.currentWidth = targetWidth
            self.currentColor = targetColor
        }
    }
    
}

extension GetBudgetView: GetBudgetViewContract {
    
    func load(success: GetBudgetResponse) {
        
        thisMonthBudget = success.budget
        thisMonthSpent = success.spent
        var restToSpent = success.budget - success.spent
        if restToSpent < 0 {
            restToSpent = 0
        }
        
        budgetString = "\(success.spent) spent already. \(restToSpent) is left to reach the budget"
        innerWidth = Float((success.spent)) / Float((success.budget))
        
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
        
        thisMonthBudgetText = CustomText.customStringLabel(label: "This month budget is \(success.budget)", fontSize: 15, fontColor: .systemBlue, fontStyle: "Trap-Medium")
        balanceBudgetText =  CustomText.customStringLabel(label: budgetString, fontSize: 15, fontStyle: "Trap-Medium")
        budgetStack = NSStackView(views: [thisMonthBudgetText, progressBar, balanceBudgetText])
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetStack?.translatesAutoresizingMaskIntoConstraints = false
        budgetStack?.wantsLayer = true
        budgetStack?.orientation = .vertical
        budgetStack?.alignment = .centerX
        budgetStack?.spacing = 35
        
        addSubview(budgetLabel)
        if let budgetStack = budgetStack {
            addSubview(budgetStack)
            
            NSLayoutConstraint.activate([
                budgetStack.centerXAnchor.constraint(equalTo: centerXAnchor),
                budgetStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
                budgetStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
                budgetStack.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        }
        
        let widthvalue = self.frame.width
        currentWidth = Float(widthvalue) * 0.80 * innerWidth
        
        innerBar.frame.size.width = widthvalue * 0.80 * CGFloat(innerWidth)
        
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 25),
            outterBar.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            outterBar.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            outterBar.heightAnchor.constraint(equalToConstant: 25),
            outterBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80),
            innerBar.topAnchor.constraint(equalTo: outterBar.topAnchor),
            innerBar.leadingAnchor.constraint(equalTo: outterBar.leadingAnchor),
            innerBar.heightAnchor.constraint(equalTo: outterBar.heightAnchor),
//            innerBar.widthAnchor.constraint(equalTo: outterBar.widthAnchor, multiplier: CGFloat(innerWidth)),
//            innerBar.widthAnchor.constraint(equalToConstant: CGFloat((Float(widthvalue) * 0.80 * innerWidth))),
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52)
        ])
    }
    
    
    func failure(error: GetBudgetError) {
        
        let noBudgetText = CustomText.customStringLabel(label: "Budget has not set for this month", fontSize: 13, fontColor: NSColor.systemRed, fontStyle: "Trap-Medium")
        let setBudgetText = CustomText.customHeaderStringLabel(label: "Set up a budget to help you stay on track with your expenses.", fontSize: 13, fontStyle: "Trap-Medium")
        textStack = NSStackView(views: [noBudgetText, setBudgetText])
        
        textStack!.orientation = .vertical
        textStack!.alignment = .centerX
        textStack!.spacing = 20
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        textStack!.translatesAutoresizingMaskIntoConstraints = false
        
        budgetLabel.wantsLayer = true
        textStack!.wantsLayer = true
        
        addSubview(budgetLabel)
        addSubview(textStack!)
        
        NSLayoutConstraint.activate([
            budgetLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            budgetLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),
            textStack!.centerXAnchor.constraint(equalTo: centerXAnchor),
            textStack!.centerYAnchor.constraint(equalTo: centerYAnchor),
//            textStack.heightAnchor.constraint(equalTo: heightAnchor),
//            textStack.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        
    }
}


