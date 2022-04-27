//
//  AppDelegate.swift
//  AverageDay
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Cocoa
import SwiftUI
import LaunchAtLogin

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    //MARK: - Properties
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var showAllEntries: NSMenuItem!
    @IBOutlet weak var launchOnLoginMenuItem: NSMenuItem!
    var statusItem: NSStatusItem?
    var menuManager: MenuManager?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        configureStatusItem()
        configureMenuManager()
        
        launchOnLoginMenuItem.state = LaunchAtLogin.isEnabled ? .on : .off
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    
    @IBAction func showAllEntries(_ sender: Any) {
        let hostingController = NSHostingController(rootView: EntriesView())
        
        let window = NSWindow(contentViewController: hostingController)
        window.title = "This Month's Entries"
        
        let controller = NSWindowController(window: window)
        
        NSApp.activate(ignoringOtherApps: true)
        
        controller.showWindow(nil)
    }
    
    
    @IBAction func toggleLaunchOnLogIn(_ sender: Any) {
        LaunchAtLogin.isEnabled.toggle()
        launchOnLoginMenuItem.state = LaunchAtLogin.isEnabled ? .on : .off
    }
}

extension AppDelegate {
    private func configureMenuManager(){
        menuManager = MenuManager(statusMenu: statusMenu)
        statusMenu.delegate = menuManager
    }
    
    private func configureStatusItem() {
        //An NSStatusItem is an item that macOS displays in the system menu.
        //The part of the menu bar to the right of the screen, it holds the
        //menu ofr the app.
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        statusItem?.menu = statusMenu
        statusItem?.button?.title = "Average Day"
        statusItem?.button?.imagePosition = .imageLeading
        statusItem?.button?.image = NSImage(systemSymbolName: "sun.and.horizon", accessibilityDescription: "Average Day")
        statusItem?.button?.font = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
    }
}

