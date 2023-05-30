//
//  File.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import AppKit
import ExpenseTrackerBackend


public class GetMonthlySpentView: NSView {
    
    var presenter: GetMonthlySpentPresenterContract
    var user: User
    init(presenter: GetMonthlySpentPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSRect())
        configureSpentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSpentView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = calendar.date(from: startDateComponents) else {
            fatalError("Failed to create the starting date.")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate)
        
        presenter.viewLoadMonthlySpent(user: user, month: formattedStartDate)
        
        
    }
}

extension GetMonthlySpentView: GetMonthlySpentViewContract {
    
    func load(success: ExpenseTrackerBackend.GetMonthlySpentResponse) {
        
        let spentLabel = CustomText.customStringLabel(label: "Spent", fontSize: 35, fontColor: NSColor.black, fontStyle: "Trap-Medium")
        let spentValue = CustomText.customStringLabel(label: String(success.spent), fontSize: 40, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        let spentStack = NSStackView(views: [spentLabel, spentValue])
        
        self.wantsLayer = true
        spentStack.wantsLayer = true
        spentStack.translatesAutoresizingMaskIntoConstraints = false
        spentStack.orientation = .vertical
        spentStack.spacing = 15
        self.layer?.backgroundColor = #colorLiteral(red: 0.9496220946, green: 0.6933776736, blue: 0.00462017348, alpha: 1)
        self.layer?.cornerRadius = 20
        
        addSubview(spentStack)
        
        NSLayoutConstraint.activate([
            
            spentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            spentStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 33),
            spentStack.heightAnchor.constraint(equalToConstant:  150),
            spentStack.widthAnchor.constraint(equalToConstant: 400),
            self.heightAnchor.constraint(equalToConstant: 120),
            self.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    func failure(error: ExpenseTrackerBackend.GetMonthlySpentError) {
        
        let spentLabel = CustomText.customStringLabel(label: "Spent", fontSize: 33, fontColor: NSColor.black, fontStyle: "Trap-Medium")
        let spentValue = CustomText.customStringLabel(label: "0.00", fontSize: 40, fontColor: NSColor.black, fontStyle: "Trap-Bold")
        let spentStack = NSStackView(views: [spentLabel, spentValue])
        
        self.wantsLayer = true
        spentStack.wantsLayer = true
        spentStack.translatesAutoresizingMaskIntoConstraints = false
        spentStack.orientation = .vertical
        spentStack.spacing = 15
        self.layer?.backgroundColor = #colorLiteral(red: 0.9496220946, green: 0.6933776736, blue: 0.00462017348, alpha: 1)
        self.layer?.cornerRadius = 20
        
        addSubview(spentStack)
        
        NSLayoutConstraint.activate([
            
            spentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            spentStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 33),
            spentStack.heightAnchor.constraint(equalToConstant:  150),
            spentStack.widthAnchor.constraint(equalToConstant: 400),
            self.heightAnchor.constraint(equalToConstant: 120),
            self.widthAnchor.constraint(equalToConstant: 320)
        ])
        print("there was no spending in this month")
    }
    
    
}
