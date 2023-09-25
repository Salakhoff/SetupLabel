//
//  ViewController.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func addButtonTapped() {
        print("Add")
    }
}

extension MainViewController {
    private func setupView() {
        title = "Текст"
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        
        navigationItem.rightBarButtonItem = addButtonItem
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9)
        ])
    }
}

