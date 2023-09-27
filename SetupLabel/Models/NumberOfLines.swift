//
//   NumberOfLines.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 27.09.2023.
//

import Foundation

enum NumberOfLines: String, CaseIterable {
    case `default` = "Сколько возможно"
    case one = "Одна"
    case two  = "Две"
    case three = "Три"
    case four = "Четыре"
    
    var numberLine: Int {
        switch self {
            
        case .default: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        }
    }
}
