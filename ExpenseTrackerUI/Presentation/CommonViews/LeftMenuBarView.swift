//
//  LeftMenuBarView.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 31/05/23.
//

import Foundation
import AppKit

class LeftMenuBar: NSView {
    
    var homeButton: NSButton!
    var transactionButton: NSButton!
    var analysisButton: NSButton!
    var innerstack: NSStackView!
    var appIcon = NSImageView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configureMenuBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMenuBar() {
        
        var image = NSImage(named: "icon")
        appIcon.image = image
        image?.size = NSSize(width: 30, height: 30)
        appIcon.imageScaling = .scaleProportionallyUpOrDown
        homeButton = customButton(image: "home", tag: 1)
        transactionButton = customButton(image: "list", tag: 2)
        analysisButton = customButton(image: "analysis", tag: 3)
        homeButton.image = homeButton.image?.tint(color: #colorLiteral(red: 0.626486361, green: 0.9017811418, blue: 0.3185373545, alpha: 1))
        innerstack = NSStackView(views: [homeButton, transactionButton, analysisButton])
        
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        innerstack.translatesAutoresizingMaskIntoConstraints = false
        innerstack.orientation = .vertical
        innerstack.distribution = .equalCentering
        
        addSubview(innerstack)
        addSubview(appIcon)
        
        NSLayoutConstraint.activate([
            innerstack.centerXAnchor.constraint(equalTo: centerXAnchor),
            innerstack.centerYAnchor.constraint(equalTo: centerYAnchor),
            innerstack.widthAnchor.constraint(equalTo: widthAnchor),
            innerstack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45)
        ])
        
        NSLayoutConstraint.activate([
            appIcon.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            appIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            appIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            appIcon.heightAnchor.constraint(equalTo: appIcon.widthAnchor)
        ])
    }
    
    func customButton(image: String, tag: Int) -> NSButton {
        let button = NSButton()
        var image = NSImage(named: image)
        button.tag = tag
        image?.size = NSSize(width: 40, height: 40)
        image = image?.tint(color: .white)
        button.wantsLayer = true
        button.isBordered = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = image
        NSLayoutConstraint.activate([
         button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        return button
    }
}


extension NSImage {
    func tint(color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()
        color.set()
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)
        image.unlockFocus()
        return image
    }
}
