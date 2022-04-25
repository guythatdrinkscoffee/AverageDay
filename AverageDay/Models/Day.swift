//
//  Day.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Foundation

struct Day: Codable {
    let id: UUID
    let date: Date
    var mood: Mood
}

extension Day {
    static var sampleDays: [Day] = [
        Day(id: UUID(), date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, mood: .okay),
        Day(id: UUID(), date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, mood: .awful),
        Day(id: UUID(), date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, mood:  .bad),
        Day(id: UUID(), date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, mood: .okay),
        Day(id: UUID(), date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, mood: .perfect),
    ]
}
