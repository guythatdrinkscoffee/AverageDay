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
    var dayManager = DayManager()
    
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
        let stopIndex = statusMenu.items.count - 5
        let itemsBefore = 2
        
        for _ in itemsBefore..<stopIndex {
            statusMenu.removeItem(at: itemsBefore)
        }
    }
    
    private func showMenuItems(){
        let dayItemFrame = NSRect(x: 0, y: 0, width: 270, height: 60)
        let dayView = DayView(frame: dayItemFrame)
        let dayItem = NSMenuItem()
      
        dayItem.title = "How was your day?"
        dayItem.view = dayView

        dayView.day = dayManager.currentDay
        
        dayView.moodSelectionHandler = { mood in
            self.dayManager.setMood(mood: mood)
        }
     
        statusMenu.insertItem(dayItem, at: 2)
    }
}
