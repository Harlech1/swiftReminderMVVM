//
//  DetailsVC+UI.swift
//  Reminder
//
//  Created by Türker Kızılcık on 17.04.2024.
//

import UIKit

extension DetailsVC {
    func initTitleTextField() -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "title".localized()
        textField.backgroundColor = .secondarySystemGroupedBackground
        textField.layer.cornerRadius = 12
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        return textField
    }

    func initDescriptionTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.backgroundColor = .secondarySystemGroupedBackground
        textView.accessibilityLabel = "description".localized()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 0, right: 0)
        textView.layer.cornerRadius = 12
        return textView
    }

    func initPlaceholderLabel() -> UILabel {
        let label = UILabel()
        label.text = "description".localized()
        label.accessibilityElementsHidden = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.placeholderText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func initDateStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }

    func initTimeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }

    func initDateLabel() -> UILabel {
        let label = UILabel()
        label.text = "\("date".localized()): "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func initTimeLabel() -> UILabel {
        let label = UILabel()
        label.text = "\("time".localized()): "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func initDatePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }

    func initTimePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }

    func initSaveOrUpdateButton() -> UIButton {
        let button = UIButton()
        button.setTitle("save".localized(), for: .normal)
        button.accessibilityLabel = "saveReminderAccessibility".localized()
        button.accessibilityHint = "saveReminderHint".localized()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.secondarySystemGroupedBackground
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(saveOrUpdateButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }
}
