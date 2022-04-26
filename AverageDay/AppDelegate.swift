//
//  AppDelegate.swift
//  AverageDay
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Cocoa


@main
class AppDelegate: NSObject, NSApplicationDelegate {
    //MARK: - Properties
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var showAllEntries: NSMenuItem!
    var statusItem: NSStatusItem?
    var menuManager: MenuManager?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        configureStatusItem()
        configureMenuManager()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    
    @IBAction func showAllEntries(_ sender: Any) {

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

