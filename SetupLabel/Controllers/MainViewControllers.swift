//
//  ViewController.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MainViewController {
    private func setupView() {
        title = "Текст"
        view.backgroundColor = .systemBackground
    }
}

