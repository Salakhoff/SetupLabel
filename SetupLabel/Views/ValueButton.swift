//
//  ValueButton.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

class ValueButton: UIButton {
    
    convenience init(titleText: String?) {
        self.init(type: .system)
        guard let titleText else { return }
        self.setTitle(titleText, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


