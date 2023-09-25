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
        let alertController = UIAlertController(title: "Введите текст для отображения", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Введите текст..."
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let addAction = UIAlertAction(title: "ОК", style: .default) { [weak self] textField in
            guard let self else { return }
            if let textField = alertController.textFields?.first, let text = textField.text {
                let trimmerText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmerText.isEmpty {
                    self.label.text = text
                } else {
                    let errorAlertController = UIAlertController(title: "Введите текст!", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                        guard let self else { return }
                        self.addButtonTapped()
                    }
                    errorAlertController.addAction(okAction)
                    present(errorAlertController, animated: true) {
                    }
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
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

