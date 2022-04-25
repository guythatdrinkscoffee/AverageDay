//
//  Mood.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Foundation

enum Mood: Int, CaseIterable {
    case awful = 0
    case bad = 1
    case okay
    case good
    case great
    case perfect
    
    var moodText: String {
        switch self {
        case .awful : return "😡"
        case .bad : return "😣"
        case .okay : return "😕"
        case .good : return "🙂"
        case .great : return "😀"
        case .perfect : return "🤩"
        }
    }
}
