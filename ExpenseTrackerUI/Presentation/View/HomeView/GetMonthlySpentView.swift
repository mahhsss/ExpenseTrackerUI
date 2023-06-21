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
    var spentValue: NSTextField!
    var currentSpent = 0
    
    init(presenter: GetMonthlySpentPresenterContract, user: User) {
        self.presenter = presenter
        self.user = user
        super.init(frame: NSZeroRect)
        configureSpentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func currentSpentUpdate(transationAmount: Int) {
        spentValue.stringValue = String(transationAmount + currentSpent)
    }
    
    func configureSpentView() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calendar.date(from: startDateComponents)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: startDate!)
        
        presenter.viewLoadMonthlySpent(user: user, month: formattedStartDate)
        
        
    }
}

extension GetMonthlySpentView: GetMonthlySpentViewContract {
    
    func load(spent: Int) {
        
        currentSpent = spent
        displayMonthlySpent(spent: spent)
    }
    
    func failure(error: String) {
        displayMonthlySpent(spent: 0)
        print(error)
    }
    
    func displayMonthlySpent(spent: Int) {
        
        let spentLabel = CustomText.customStringLabel(label: "Spent", fontSize: 20, fontColor: NSColor.black, fontStyle: "Trap-Medium")
        spentValue = CustomText.customStringLabel(label: String(spent), fontSize: 22, fontColor: NSColor.black, fontStyle: "Trap-Bold")
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
            spentStack.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 6),
            spentStack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.85),
            spentStack.widthAnchor.constraint(equalToConstant: 400),
//            self.heightAnchor.constraint(equalToConstant: 120),
//            self.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
    
}
