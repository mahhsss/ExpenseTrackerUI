//
//  CustomText.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 25/05/23.
//

import Foundation
import AppKit


class CustomText {
    
    static func customStringLabel(label: String, fontSize: Int, fontColor: NSColor? = nil, fontStyle: String? = nil) -> NSTextField {
        
        let textFiled = NSTextField(labelWithString: label)
        textFiled.font = .systemFont(ofSize: CGFloat(fontSize))
        if let fontColor = fontColor {
            textFiled.textColor = fontColor
        }
        if let fontStyle = fontStyle {
            textFiled.font = NSFont(name: fontStyle, size: CGFloat(fontSize))
        }
        textFiled.isEditable = false
        textFiled.isSelectable = false
        return textFiled
    }
    
    static func customHeaderStringLabel(label: String, fontSize: Int, fontColor: NSColor? = nil, fontStyle: String? = nil) -> NSTextField {
        
        let textField = NSTextField(labelWithString: label)
        textField.font = .systemFont(ofSize: CGFloat(fontSize))
        if let fontColor = fontColor {
            textField.textColor = fontColor
        }
        if let fontStyle = fontStyle {
            textField.font = NSFont(name: fontStyle, size: CGFloat(fontSize))
        }
        textField.isEditable = false
        textField.isSelectable = false
        
        let attributedString = NSMutableAttributedString(string: label)
        let range = NSRange(location: 0, length: attributedString.length)
        let borderColor: CGColor = .init(srgbRed: 0.3159786165, green: 0.5165252209, blue: 1, alpha: 1)
        let borderWidth: CGFloat = 2.0
        attributedString.addAttribute(.strokeColor, value: borderColor, range: range)
        attributedString.addAttribute(.strokeWidth, value: -borderWidth, range: range)

        textField.attributedStringValue = attributedString
        return textField
    }
}
