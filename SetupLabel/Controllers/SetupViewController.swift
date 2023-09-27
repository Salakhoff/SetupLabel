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
    
    private lazy var pickerView = UIPickerView()
    
    private lazy var textFieldToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, cancelButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setDelegate()
        addTarget()
        updateValue()
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
        
        colorTextField.inputView = pickerView
        colorTextField.inputAccessoryView = textFieldToolbar
        
        numberLineTextField.inputView = pickerView
        numberLineTextField.inputAccessoryView = textFieldToolbar
    }
    
    private func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func updateValue() {
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
        settingFontSlider.value = Float(textSettings.fontSize)
        
        colorTextField.text = textSettings.textColor.rawValue
        numberLineTextField.text = "\(textSettings.numberOfLines.rawValue)"
    }
    
    private func addTarget() {
        settingFontSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func cancelButtonTapped() {
        if colorTextField.isEditing {
            colorTextField.resignFirstResponder()
        } else if numberLineTextField.isEditing {
            numberLineTextField.resignFirstResponder()
        }
    }
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        textSettings.fontSize = CGFloat(sender.value)
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
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
        if colorTextField.isEditing {
            return ColorChoice.allCases.count
        } else if numberLineTextField.isEditing {
            return NumberOfLines.allCases.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if colorTextField.isEditing {
            return ColorChoice.allCases[row].rawValue
        } else if numberLineTextField.isEditing {
            return NumberOfLines.allCases[row].rawValue
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if colorTextField.isEditing {
            textSettings.textColor = ColorChoice.allCases[row]
        } else if numberLineTextField.isEditing {
            textSettings.numberOfLines = NumberOfLines.allCases[row]
        }
        updateValue()
    }
}
