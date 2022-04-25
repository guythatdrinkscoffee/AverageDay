//
//  MenuManager.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Foundation
import AppKit

class MenuManager: NSObject, NSMenuDelegate {
    
    let statusMenu: NSMenu
    var menuIsOpen = false
    
    
    init(statusMenu: NSMenu){
        self.statusMenu = statusMenu
        super.init()
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        menuIsOpen = true
        showMenuItems()
    }
    
    func menuDidClose(_ menu: NSMenu) {
        menuIsOpen = false
        clearMenu()
    }
    
    private func clearMenu(){
        let stopIndex = statusMenu.items.count - 2
        let itemsBefore = 2
        
        for _ in itemsBefore..<stopIndex {
            statusMenu.removeItem(at: itemsBefore)
        }
    }
    
    private func showMenuItems(){
        let dayItemFrame = NSRect(x: 0, y: 0, width: 270, height: 60)
        let dayItem = NSMenuItem()
        let dayView = DayView(frame: dayItemFrame)
        dayItem.view = dayView
        dayItem.title = "How was your day?"
        statusMenu.insertItem(dayItem, at: 2)
    }
}
