//
//  SetupViewController.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension SetupViewController {
    private func setupView() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
    }
}
