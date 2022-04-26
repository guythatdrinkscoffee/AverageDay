//
//  Mood.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Foundation

enum Mood: Int, CaseIterable, Codable {
    case awful = 0
    case bad = 1
    case okay
    case good
    case perfect
    case noEntry
    
    var moodText: String {
        switch self {
        case .awful : return "😡"
        case .bad : return "😣"
        case .okay : return "🙂"
        case .good : return "😃"
        case .perfect : return "🤩"
        case .noEntry : return "🤷‍♂️"
        }
    }
}


