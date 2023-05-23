//
//  main.swift
//  ExpenseTrackerUI
//
//  Created by mahesh-pt6305 on 23/05/23.
//

import Foundation
import AppKit

let app = NSApplication.shared

let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
