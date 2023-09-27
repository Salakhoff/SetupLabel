//
//  ColorChoice.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 27.09.2023.
//

import UIKit

enum ColorChoice: String, CaseIterable {
    
    case black = "Черный"
    case red = "Красный"
    case green = "Зеленый"
    case blue = "Синий"
    case yellow = "Желтый"
    
    var systemColor: UIColor {
        switch self {
        case .red: UIColor.systemRed
        case .green: UIColor.systemGreen
        case .blue: UIColor.systemBlue
        case .yellow: UIColor.systemYellow
        case .black: UIColor.black
            
        }
    }
}
