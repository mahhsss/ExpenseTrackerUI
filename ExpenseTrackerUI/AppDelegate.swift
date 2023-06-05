//
//  AppDelegate.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var window: NSWindow!
    var router: Router?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height), styleMask: [.closable, .miniaturizable, .resizable, .titled, .fullSizeContentView], backing: .buffered, defer: true, screen: nil)
//        window.title = "EXPENZO"
        window.titlebarSeparatorStyle = .none
        window.titlebarAppearsTransparent = true
        router = Router(window: window)
        window.delegate = self
        router?.launch()
        window.makeKeyAndOrderFront(nil)
    }
    
    class CustomToolbar: NSToolbar {
        func sizeMode(forToolbarSizeMode sizeMode: NSToolbar.SizeMode) -> NSToolbar.SizeMode {
            return .regular
        }
        
        func height(for: NSToolbar.SizeMode) -> CGFloat {
            return 60 // Adjust the value to increase the toolbar height
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

