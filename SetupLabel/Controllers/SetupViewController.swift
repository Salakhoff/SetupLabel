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
    
    private var colorChoice: ColorChoice = .blue
    var textSettings = TextSettings(fontSize: 20, textColor: .black, numberOfLines: 0)
    
    private let settingFontLabel = DescriptionLabel(labelText: "Размера шрифта:")
    private let settingColorLabel = DescriptionLabel(labelText: "Цвет текста:")
    private let numberLineLabel = DescriptionLabel(labelText: "Количество строк:")
    
    private let valueSliderLabel = ValueLabel(labelText: "20")
    
    private lazy var colorButton = ValueButton(titleText: "Выбрать цвет")
    private lazy var numberLineButton = ValueButton(titleText: "Выбрать количество строк")
    
    private lazy var pickerColorView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    }()
    
    private let settingFontSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 20
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        pickerColorView.delegate = self
        pickerColorView.dataSource = self
        
        settingFontSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged(_:)), for: .valueChanged)
        colorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        numberLineButton.addTarget(self, action: #selector(numberOfLinesButtonTapped), for: .touchUpInside)
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
        view.addSubview(colorButton)
        view.addSubview(numberLineLabel)
        view.addSubview(numberLineButton)
        view.addSubview(pickerColorView)
        
        setConstraints()
    }
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        textSettings.fontSize = CGFloat(sender.value)
        valueSliderLabel.text = "\(Int(textSettings.fontSize))"
    }
    
    @objc private func colorButtonTapped() {
        
        if let row = ColorChoice.allCases.firstIndex(of: colorChoice) {
            pickerColorView.selectRow(row, inComponent: 0, animated: true)
        }
        
        pickerColorView.isHidden = false
    }
    
    @objc private func numberOfLinesButtonTapped() {
        // Показать контроллер выбора количества строк и обновить значение textSettings.numberOfLines
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
            
            colorButton.topAnchor.constraint(equalTo: settingColorLabel.bottomAnchor, constant: 10),
            colorButton.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            
            numberLineLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 20),
            numberLineLabel.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            numberLineLabel.trailingAnchor.constraint(equalTo: settingFontSlider.trailingAnchor),
            
            numberLineButton.topAnchor.constraint(equalTo: numberLineLabel.bottomAnchor, constant: 10),
            numberLineButton.leadingAnchor.constraint(equalTo: settingFontSlider.leadingAnchor),
            
            pickerColorView.topAnchor.constraint(equalTo: numberLineButton.bottomAnchor, constant: 20),
            pickerColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        colorChoice = ColorChoice.allCases[row]
        textSettings.textColor = colorChoice.systemColor
        colorButton.setTitle("Вы выбрали цвет: \(colorChoice.rawValue)", for: .normal)
        pickerColorView.isHidden = true
    }
}
