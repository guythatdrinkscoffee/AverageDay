//
//  DayManager.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/25/22.
//

import Foundation

class DayManager {
    //MARK: - Properties
    var days: [Day]
    var dataStore = DayDataStore()
    var currentDay: Day
    
    //MARK: - Lifecycle
    init(){
        days = dataStore.readDays()
        
        if let today = days.first(where: { Calendar.current.isDateInToday($0.date)}) {
            currentDay = today
        } else {
            currentDay = Day(id: UUID(), date: Date(), mood: .noEntry)
            days.append(currentDay)
        }
    }
    
    func setMood(mood: Mood){
        let firstIndex = days.firstIndex { $0.id == currentDay.id }
        
        if let firstIndex = firstIndex {
            days[firstIndex].mood = mood
            dataStore.save(days: days)
            
            currentDay = days[firstIndex]
        }
    }
}
