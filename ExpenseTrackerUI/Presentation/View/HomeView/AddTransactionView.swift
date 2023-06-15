//
//  AddTransactionView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 02/03/23.
//

import Foundation
import ExpenseTrackerBackend
import AppKit

class AddTransactionView: NSView {
    
    var user: User
    var presenter: AddTransactionContract
    var amount = NSTextField()
    var date = NSDatePicker()
    var category = NSPopUpButton()
    var transactionType = NSPopUpButton()
    var currencyType = NSPopUpButton()
    var note = NSTextField()
    var addTransactionStack: NSStackView!
    var addTransactionButton = NSButton()
    let numberFormatter = NumberFormatterr()
    var categoryLable = NSTextField()
    var categoryBox = NSBox()
    
    init(user: User, presenter: AddTransactionContract) {
        self.user = user
        self.presenter = presenter
        super.init(frame: NSRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        if superview != nil {
            addTransactionView()
        }
    }
    
}

extension AddTransactionView {
    
    func addTransactionView() {
        
        let amountLable = CustomText.customStringLabel(label: "Amount", fontSize: 15)
        let dateLable = CustomText.customStringLabel(label: "Date", fontSize: 15)
        categoryLable = CustomText.customStringLabel(label: "Category", fontSize: 15)
        let transactionTypeLable = CustomText.customStringLabel(label: "Transaction type", fontSize: 15)
        let currencyLable = CustomText.customStringLabel(label: "Currency type", fontSize: 15)
        let noteLable = CustomText.customStringLabel(label: "Note", fontSize: 15)
        let amountBox = customTextBox(textField: amount, name: "amount")
        let dateBox = customDateBox(date: date)
        categoryBox = customPopUpButton(popUpButton: category)
        let transactionTypeBox = customPopUpButton(popUpButton: transactionType)
        let currencyTypeBox = customPopUpButton(popUpButton: currencyType)
        let noteBox = customTextBox(textField: note, name: "note")
        addTransactionButton = customAddTransactionButton(addTransaction: addTransactionButton)
        amount.formatter = numberFormatter
        
        for category in TransactionCategory.allCases {
            self.category.addItem(withTitle: category.rawValue)
        }
        
        for transactionType in TransactionType.allCases {
            self.transactionType.addItem(withTitle: transactionType.rawValue)
        }
        
        for currencyType in CurrencyType.allCases {
            self.currencyType.addItem(withTitle: currencyType.rawValue)
        }
        
        transactionType.action = #selector(checkTransaction(_:))
        transactionType.target = self
        addTransactionButton.action = #selector(addTransaction(_:))
        
        addTransactionStack = NSStackView(views: [amountLable, amountBox, dateLable, dateBox, transactionTypeLable, transactionTypeBox, categoryLable, categoryBox, currencyLable, currencyTypeBox, noteLable, noteBox])
        addTransactionStack.orientation = .vertical
        addTransactionStack.alignment = .left
        addTransactionStack.spacing = 10
        
        addTransactionStack.translatesAutoresizingMaskIntoConstraints = false
        addTransactionButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(addTransactionStack)
        addSubview(addTransactionButton)
        
        NSLayoutConstraint.activate([
            addTransactionStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTransactionStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            addTransactionButton.topAnchor.constraint(equalTo: addTransactionStack.bottomAnchor, constant: 70),
            addTransactionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
        
        
        
        
        
    }
    
    @objc func checkTransaction(_ sender: NSPopUpButton) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        
        if sender.title == "Income" {
//            category.isHidden = true
            categoryLable.textColor = #colorLiteral(red: 0.6575580835, green: 0.6575580835, blue: 0.6575580835, alpha: 1)
            categoryBox.layer?.backgroundColor = #colorLiteral(red: 0.09780230373, green: 0.09780230373, blue: 0.09780230373, alpha: 1)
            categoryLable.layer?.add(transition, forKey: "colorChangeAnimation")
            categoryBox.layer?.add(transition, forKey: "colorChangeAnimation")
            category.isHighlighted = false
            category.isEnabled = false
            category.pullsDown = true
            category.title = "-"
        }
        else {
//            category.isHidden = false
            categoryLable.textColor = .white
            categoryBox.layer?.backgroundColor = .black
            categoryLable.layer?.add(transition, forKey: "colorChangeAnimation")
            categoryBox.layer?.add(transition, forKey: "colorChangeAnimation")
            category.isHighlighted = true
            category.isEnabled = true
            category.removeItem(withTitle: "-")
            category.pullsDown = false
            
        }
    }
    
    @objc func addTransaction(_ sender: NSButton) {
        
        if amount.stringValue == "" || Int(amount.stringValue)! < 1 {
            
            var enterAmountText = CustomText.customStringLabel(label: "Enter the transaction amount", fontSize: 12, fontColor: NSColor.red)
            
            addTransactionStack.addArrangedSubview(enterAmountText)
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.x")
            shakeAnimation.duration = 0.05
            shakeAnimation.repeatCount = 5
            shakeAnimation.autoreverses = true
            shakeAnimation.fromValue = NSValue(point: NSPoint(x: -5, y: 0))
            shakeAnimation.toValue = NSValue(point: NSPoint(x: 5, y: 0))
                    
            addTransactionStack.layer?.add(shakeAnimation, forKey: "shakeAnimation")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                enterAmountText.removeFromSuperview()
            }
        }
        
        else {
            
            var transactionType = TransactionType.income
            var currencyType = CurrencyType.bankTransaction
            if self.transactionType.title == "Spending" {
                transactionType = TransactionType.spending
            }
            if self.currencyType.title == "Cash" {
                currencyType = CurrencyType.cash
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date.dateValue)
            let transaction: Transaction!
            if transactionType == TransactionType.income {
                transaction  = Transaction(transactionId: 0, userId: user.userId, amount: Int(amount.stringValue) ?? 0, transactionType: transactionType, currencyType: currencyType, date: dateString, note: note.stringValue)
            }
            else {
                transaction = Transaction(transactionId: 0, userId: user.userId, amount: Int(amount.stringValue) ?? 0, transactionType: transactionType, currencyType: currencyType, date: dateString, category: category.title, note: note.stringValue)
            }
           
            
            presenter.viewDidLoadExpense(user: user, transaction: transaction)
        }
    }
    
    func customAddTransactionButton(addTransaction: NSButton) -> NSButton {
        
        addTransaction.title = "Add Transaction"
        addTransaction.translatesAutoresizingMaskIntoConstraints = false
        addTransaction.wantsLayer = true
        addTransaction.layer?.backgroundColor = .init(red: 0.2, green: 0.5, blue: 0.7, alpha: 0.5)
        addTransaction.contentTintColor = .white
        addTransaction.isBordered = false
        addTransaction.alignment = .center
        addTransaction.focusRingType = .none
        addTransaction.font = .systemFont(ofSize: 13)
        
        addTransaction.layer?.cornerRadius = 10
        addTransaction.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTransaction.heightAnchor.constraint(equalToConstant: 35),
            addTransaction.widthAnchor.constraint(equalToConstant: 135),
        ])
        return addTransaction
    }
    
    func customTextBox(textField: NSTextField, name: String) -> NSBox {
        
        let borderBox = NSBox()
        borderBox.boxType = .custom
        textField.placeholderString = "Enter Your \(name)"
        textField.translatesAutoresizingMaskIntoConstraints =  false
        textField.isEditable = true
        textField.wantsLayer = true
        textField.isSelectable = true
        textField.isBordered = false
        textField.focusRingType = .none
        textField.usesSingleLineMode = true
        textField.font = .systemFont(ofSize: 15)
        textField.wantsLayer = true
        textField.backgroundColor = .none
        borderBox.contentView = textField
        borderBox.wantsLayer = true
        borderBox.layer?.cornerRadius = 10
        borderBox.borderWidth = 0
        borderBox.layer?.backgroundColor = .black
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            borderBox.widthAnchor.constraint(equalToConstant: 300),
            borderBox.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        return borderBox
    }
    
    func customPopUpButton(popUpButton: NSPopUpButton) -> NSBox {
        
        let borderBox = NSBox()
        borderBox.boxType = .custom
        popUpButton.isBordered = false
        popUpButton.isHighlighted = false
        popUpButton.preferredEdge = .maxY
        popUpButton.translatesAutoresizingMaskIntoConstraints = false
        popUpButton.wantsLayer = true
        popUpButton.font = .systemFont(ofSize: 15)
        borderBox.contentView = popUpButton
        borderBox.wantsLayer = true
        borderBox.layer?.cornerRadius = 10
        borderBox.borderWidth = 0
        borderBox.layer?.backgroundColor = .black
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popUpButton.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            popUpButton.widthAnchor.constraint(equalTo: borderBox.widthAnchor, multiplier: 0.95),
            borderBox.widthAnchor.constraint(equalToConstant: 300),
            borderBox.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        return borderBox
    }
    
    func customDateBox(date: NSDatePicker) -> NSBox {
        
        let borderBox = NSBox()
        borderBox.boxType = .custom
        date.datePickerStyle = .textFieldAndStepper
        date.datePickerMode = .single
        date.isBordered = false
        date.datePickerElements = [.yearMonthDay]
        date.dateValue = Date()
        date.alignment = .center
        borderBox.contentView = date
        borderBox.wantsLayer = true
        borderBox.layer?.cornerRadius = 10
        borderBox.borderWidth = 0
        borderBox.layer?.backgroundColor = .black
        date.translatesAutoresizingMaskIntoConstraints = false
        borderBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.centerYAnchor.constraint(equalTo: borderBox.centerYAnchor),
            date.widthAnchor.constraint(equalTo: borderBox.widthAnchor, multiplier: 0.97),
            borderBox.widthAnchor.constraint(equalToConstant: 300),
            borderBox.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        return borderBox
    }
    
}

extension AddTransactionView: AddNewTransactionContract {
    func load(success: AddNewTransactionResponse) {
        print("\n\(success.message)")
    }
    
    func failure(error: AddNewTransactionError) {
        print("\n\(error.error)")
    }
    
    
    
}


public class NumberFormatterr: Formatter {
    public override func string(for obj: Any?) -> String? {
        return obj as? String
    }

    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
                                 for string: String,
                                 errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject
        return true
    }

    public override func isPartialStringValid(_ partialStringPtr: AutoreleasingUnsafeMutablePointer<NSString>,
                                       proposedSelectedRange proposedSelRangePtr: NSRangePointer?,
                                       originalString origString: String,
                                       originalSelectedRange origSelRange: NSRange,
                                       errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        let partialString = partialStringPtr.pointee as String

        // Use regular expression to check if the partial string contains only numbers
        let regex = try! NSRegularExpression(pattern: "^[0-9]*$")
        let range = NSRange(location: 0, length: partialString.utf16.count)
        let matches = regex.matches(in: partialString, options: [], range: range)
        
        return matches.count > 0
    }
}
