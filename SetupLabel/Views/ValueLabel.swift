//
//  ValueLabel.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

class ValueLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    convenience init(labelText: String?) {
        self.init()
        guard let labelText else { return }
        self.text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ValueLabel {
    private func setupLabel() {
        font = .systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
