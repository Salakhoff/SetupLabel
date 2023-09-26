//
//  SetupViewController.swift
//  SetupLabel
//
//  Created by Ильфат Салахов on 25.09.2023.
//

import UIKit

protocol TextSettingsDelegate: AnyObject {
    func didUpdateTextSettings(textSettings: TextSettings)
}

class SetupViewController: UIViewController {
    
    weak var delegate: TextSettingsDelegate?
    
    private var textSettings = TextSettings(fontSize: 1, textColor: .black, numberOfLines: 0)
    
    private let settingFontLabel = DescriptionLabel(labelText: "Размера шрифта:")
    private let settingColorLabel = DescriptionLabel(labelText: "Цвет текста:")
    private let numberLineLabel = DescriptionLabel(labelText: "Количество строк:")
    
    private let valueSliderLabel = ValueLabel(labelText: "0")
    
    private lazy var colorButton = ValueButton(titleText: "Выбрать цвет")
    private lazy var numberLineButton = ValueButton(titleText: "Выбрать количество строк")
    
    private let settingFontSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        settingFontSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        textSettings.fontSize = CGFloat(sender.value)
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
    }
}

extension SetupViewController {
    private func setupView() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
        
        view.addSubview(settingFontLabel)
        view.addSubview(settingFontSlider)
        view.addSubview(valueSliderLabel)
        view.addSubview(settingColorLabel)
        view.addSubview(colorButton)
        view.addSubview(numberLineLabel)
        view.addSubview(numberLineButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            settingFontLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingFontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingFontLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            valueSliderLabel.topAnchor.constraint(equalTo: settingFontLabel.bottomAnchor, constant: 10),
            valueSliderLabel.trailingAnchor.constraint(equalTo: settingFontLabel.trailingAnchor),
            valueSliderLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            settingFontSlider.leadingAnchor.constraint(equalTo: settingFontLabel.leadingAnchor),
            settingFontSlider.centerYAnchor.constraint(equalTo: valueSliderLabel.centerYAnchor),
            settingFontSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            settingColorLabel.topAnchor.constraint(equalTo: valueSliderLabel.bottomAnchor, constant: 20),
            settingColorLabel.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            settingColorLabel.trailingAnchor.constraint(equalTo: settingFontSlider.trailingAnchor),
            
            colorButton.topAnchor.constraint(equalTo: settingColorLabel.bottomAnchor, constant: 10),
            colorButton.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            
            numberLineLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 20),
            numberLineLabel.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            numberLineLabel.trailingAnchor.constraint(equalTo: settingFontSlider.trailingAnchor),
            
            numberLineButton.topAnchor.constraint(equalTo: numberLineLabel.bottomAnchor, constant: 10),
            numberLineButton.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
        ])
    }
}
