//
//  GetMonthlyIncomeView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class GetMonthlyIncomeView: NSView {
    
    var presenter: GetMonthlyIncomePresenterContract?
    var user: User
    public init(presenter: GetMonthlyIncomePresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
        configureIncomeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureIncomeView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        presenter?.viewLoadMonthlySpent(user: user, month: formattedStartDate)
        
        
    }
}

extension GetMonthlyIncomeView: GetMonthlyIncomeViewContract {
    
    func load(success: ExpenseTrackerBackend.GetMonthlyIncomeResponse) {
        
        
        let incomeLabel = CustomText.customStringLabel(label: "Income", fontSize: 20, fontColor: NSColor.black, fontStyle: "Trap-Medium")
        let incomeValue = CustomText.customStringLabel(label: String(success.income), fontSize: 22, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        let incomeStack = NSStackView(views: [incomeLabel, incomeValue])
        
        self.wantsLayer = true
        incomeStack.wantsLayer = true
        incomeStack.translatesAutoresizingMaskIntoConstraints = false
        incomeStack.orientation = .vertical
        incomeStack.spacing = 15
        self.layer?.backgroundColor = #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1)
        self.layer?.cornerRadius = 20
        
        addSubview(incomeStack)
        
        NSLayoutConstraint.activate([
            
            incomeStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            incomeStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 6),
            incomeStack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.85),
            incomeStack.widthAnchor.constraint(equalToConstant: 400),
//            self.heightAnchor.constraint(equalToConstant: 120),
//            self.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    func failure(error: ExpenseTrackerBackend.GetMonthlyIncomeError) {
        
        let spentLabel = CustomText.customStringLabel(label: "Income", fontSize: 20, fontColor: NSColor.black, fontStyle: "Trap-Medium")
        let spentValue = CustomText.customStringLabel(label: "0.00", fontSize: 22, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        let spentStack = NSStackView(views: [spentLabel, spentValue])
        
        self.wantsLayer = true
        spentStack.wantsLayer = true
        spentStack.translatesAutoresizingMaskIntoConstraints = false
        spentStack.orientation = .vertical
        spentStack.spacing = 15
        self.layer?.backgroundColor = #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1)
        self.layer?.cornerRadius = 20
        
        addSubview(spentStack)
        
        NSLayoutConstraint.activate([
            
            spentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            spentStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 6),
            spentStack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.85),
            spentStack.widthAnchor.constraint(equalToConstant: 400),
//            self.heightAnchor.constraint(equalToConstant: 120),
//            self.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
}
