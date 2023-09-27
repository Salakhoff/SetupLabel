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

    private var textSettings = TextSettings()
    
    private let settingFontLabel = DescriptionLabel(labelText: "Размера шрифта:")
    private let settingColorLabel = DescriptionLabel(labelText: "Цвет текста:")
    private let numberLineLabel = DescriptionLabel(labelText: "Количество строк:")
    
    private let valueSliderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingFontSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 20
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var colorTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var numberLineTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var pickerColorView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setDelegate()
        addTarget()
        updateValue()
        
        colorTextField.inputView = pickerColorView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.didUpdateTextSettings(textSettings: textSettings)
    }
    
    private func setupView() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
        
        view.addSubview(settingFontLabel)
        view.addSubview(settingFontSlider)
        view.addSubview(valueSliderLabel)
        view.addSubview(settingColorLabel)
        view.addSubview(colorTextField)
        view.addSubview(numberLineLabel)
        view.addSubview(numberLineTextField)
        view.addSubview(pickerColorView)
    }
    
    private func setDelegate() {
        pickerColorView.delegate = self
        pickerColorView.dataSource = self
    }
    
    private func updateValue() {
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
        settingFontSlider.value = Float(textSettings.fontSize)
        
        colorTextField.text = textSettings.textColor.rawValue
        numberLineTextField.text = "\(textSettings.numberOfLines)"
    }
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        textSettings.fontSize = CGFloat(sender.value)
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
    }
    
    @objc private func colorTextFieldTapped() {
        // Реализация по нажатию на текстфилд по выбору цвета
    }
    
    @objc private func numberOfLinesTextFieldTapped() {
        // Показать контроллер выбора количества строк и обновить значение textSettings.numberOfLines
    }
    
    private func addTarget() {
        settingFontSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged(_:)), for: .valueChanged)
        colorTextField.addTarget(self, action: #selector(colorTextFieldTapped), for: .valueChanged)
        numberLineTextField.addTarget(self, action: #selector(numberOfLinesTextFieldTapped), for: .valueChanged)
    }
}

extension SetupViewController {
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
            
            colorTextField.topAnchor.constraint(equalTo: settingColorLabel.bottomAnchor, constant: 10),
            colorTextField.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            colorTextField.trailingAnchor.constraint(equalTo: valueSliderLabel.trailingAnchor),
            
            numberLineLabel.topAnchor.constraint(equalTo: colorTextField.bottomAnchor, constant: 20),
            numberLineLabel.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            numberLineLabel.trailingAnchor.constraint(equalTo: settingFontSlider.trailingAnchor),
            
            numberLineTextField.topAnchor.constraint(equalTo: numberLineLabel.bottomAnchor, constant: 10),
            numberLineTextField.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            numberLineTextField.trailingAnchor.constraint(equalTo: valueSliderLabel.trailingAnchor)
        ])
    }
}

extension SetupViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ColorChoice.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ColorChoice.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textSettings.textColor = ColorChoice.allCases[row]
        updateValue()
    }
}
