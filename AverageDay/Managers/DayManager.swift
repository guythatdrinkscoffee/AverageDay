//
//  DayManager.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/25/22.
//

import Foundation
import Combine

class DayManager {
    //MARK: - Properties
    var entries: [String: [Day]] = [:]
    var dataStore = DataStore()
    var currentDay: Day!
    
    init(){
        //Read the entries from the JSON file
        entries = dataStore.readEntries()
        
        configureEntries()
        configureCurrentDay()
    }
    
    private func configureEntries(){
        let startOfMonth = Date.startOfCurrentMonth()
        let components = Calendar.current.dateComponents([.year,.month,.day], from: startOfMonth)
        let monthNames = Calendar.current.monthSymbols
        let monthString = "\(monthNames[components.month!])_\(components.year!)"
        let entriesThisMonth = entries[monthString]
        
        if entriesThisMonth == nil {
            let entriesForMonth = configureCurrentMonthEntries(startOfMonth: startOfMonth)
            entries[monthString] = entriesForMonth
            dataStore.save(entries: entries)
        }
    }
    
    private func configureCurrentDay() {
        let thisMonthsEntries = entries[.currentMonthString]
        
        if let thisMonthsEntries = thisMonthsEntries {
            currentDay = thisMonthsEntries.first {
                Calendar.current.isDateInToday($0.date)
            }
        }
    }
    
    private func configureCurrentMonthEntries(startOfMonth: Date) -> [Day]{
        var entriesInMonth: [Day] = []
        let numberOfDaysInMonth = Calendar.current.range(of: .day, in: .month, for: startOfMonth)!
        for i in 0..<numberOfDaysInMonth.count {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startOfMonth)!
            let entry = Day(id: UUID(), date: date, mood: .noEntry)
            entriesInMonth.append(entry)
        }
        return entriesInMonth
    }
    
    public func setMood(mood: Mood){
        guard var entriesThisMonth = entries[.currentMonthString] else {
            return
        }
        
        let indexOfToday = entriesThisMonth.firstIndex(where: {
            Calendar.current.isDateInToday($0.date)
        })
        
        if let indexOfToday = indexOfToday {
            entriesThisMonth[indexOfToday].mood = mood
            entries[.currentMonthString] = entriesThisMonth
            dataStore.save(entries: entries)
            currentDay = entriesThisMonth[indexOfToday]
        }
    }
}

extension Date {
    static func startOfCurrentMonth() -> Date {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()))
        let startOfMonth = calendar.date(from: dateComponents)!
        return startOfMonth
    }
    
    static func endOfCurrentMonth() -> Date {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()),day: calendar.component(.day, from: Date()))
        let startOfMonth = calendar.date(from: dateComponents)!
        let startOfFollowingMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        let endOfCurrentMonth = calendar.date(byAdding: .day, value: -1, to: startOfFollowingMonth)
        return endOfCurrentMonth!
    }
}

extension String {
    static var currentMonthString : String {
        let startOfMonth = Date.startOfCurrentMonth()
        let components = Calendar.current.dateComponents([.year,.month,.day], from: startOfMonth)
        let monthNames = Calendar.current.monthSymbols
        let monthString = "\(monthNames[components.month!])_\(components.year!)"
        return monthString
    }
}
