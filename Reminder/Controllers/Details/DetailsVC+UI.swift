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
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
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
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 0)
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
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(UIColor.secondarySystemGroupedBackground, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(saveOrUpdateButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }

    func addSubviews() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        descriptionTextView.addSubview(placeholderLabel)
        view.addSubview(dateStackView)
        view.addSubview(timeStackView)
        view.addSubview(saveOrUpdateButton)

        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(datePicker)

        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(timePicker)
    }

    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    func setupToolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.sizeToFit()
        toolbar.items = [flexibleSpace, doneButton]
        descriptionTextView.inputAccessoryView = toolbar
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),

            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2),

            placeholderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 8),
            placeholderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 6),

            dateStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            dateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            timeStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 16),
            timeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            saveOrUpdateButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 16),
            saveOrUpdateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            saveOrUpdateButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
        ])
    }

    @objc func saveOrUpdateButtonTapped() {
        let date = DateFormatterManager.shared.dateFormatter.string(from: datePicker.date)
        let time = DateFormatterManager.shared.timeFormatter.string(from: timePicker.date)

        guard
            let title = titleTextField.text,
            let description = descriptionTextView.text
        else { return }

        if recievedReminder == nil {
            ReminderManager.shared.addReminder(title: title, description: description, date: date, time: time)
        } else {
            if let index = ReminderManager.shared.reminders.firstIndex(where: { $0 == recievedReminder }) {
                var reminder = ReminderManager.shared.reminders[index]
                reminder.date = date
                reminder.time = time
                reminder.title = title
                reminder.description = description
            }
        }

        ReminderManager.shared.saveReminders()

        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func loadReminderDetails() {
        titleTextField.text = recievedReminder?.title
        descriptionTextView.text = recievedReminder?.description

        guard
            let dateString = recievedReminder?.date,
            let timeString = recievedReminder?.time,
            let date = DateFormatterManager.shared.dateFormatter.date(from: dateString),
            let time = DateFormatterManager.shared.timeFormatter.date(from: timeString)
        else { return }

        datePicker.date = date
        timePicker.date = time
    }
}
