//
//  DetailsViewController.swift
//  Reminder
//
//  Created by Türker Kızılcık on 2.02.2024.
//

import UIKit

class DetailsVC: UIViewController  {

    var remindersVM = RemindersVM()

    var selectedIndex = -1

    let titleTextField : UITextField = {
        let textField = UITextField()
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
    }()

    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemGroupedBackground
        textView.accessibilityLabel = "description".localized()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 0, right: 0)
        textView.layer.cornerRadius = 12
        return textView
    }()

    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "description".localized()
        label.accessibilityElementsHidden = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.placeholderText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()

    let timeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()

    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "\("date".localized()): "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "\("time".localized()): "
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let saveOrUpdateButton: UIButton = {
        let button = UIButton()
        button.setTitle("save".localized(), for: .normal)
        button.accessibilityLabel = "saveReminderAccessibility".localized()
        button.accessibilityHint = "saveReminderHint".localized()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.secondarySystemGroupedBackground
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    let toolbar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGroupedBackground

        title = "details".localized()

        titleTextField.delegate = self
        descriptionTextView.delegate = self

        saveOrUpdateButton.addTarget(self, action: #selector(saveOrUpdateButtonTapped), for: .touchUpInside)

        addSubviews()
        addTapGesture()
        setupToolbar()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if selectedIndex != -1 {
            loadReminderDetails()   
            saveOrUpdateButton.setTitle("update".localized(), for: .normal)
        }

        placeholderLabel.isHidden = !descriptionTextView.text.isEmpty
    }

    // MARK: Private Functions
    private func loadReminderDetails() {
        titleTextField.text = remindersVM.reminders[selectedIndex].title
        descriptionTextView.text = remindersVM.reminders[selectedIndex].description

        let dateString = remindersVM.reminders[selectedIndex].date
        let timeString = remindersVM.reminders[selectedIndex].time

        guard
            let date = DateFormatterManager.shared.dateFormatter.date(from: dateString),
            let time = DateFormatterManager.shared.timeFormatter.date(from: timeString)
        else { return }

        datePicker.date = date
        timePicker.date = time
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupToolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.sizeToFit()
        toolbar.items = [flexibleSpace, doneButton]
        descriptionTextView.inputAccessoryView = toolbar
    }

    private func addSubviews() {
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

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),

            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),

            placeholderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 10),
            placeholderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 10),

            dateStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            timeStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            timeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            timeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            saveOrUpdateButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 10),
            saveOrUpdateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            saveOrUpdateButton.widthAnchor.constraint(equalToConstant: 72),
        ])
    }

    // MARK: Objc Functions
    @objc func saveOrUpdateButtonTapped() {
        let date = DateFormatterManager.shared.dateFormatter.string(from: datePicker.date)
        let time = DateFormatterManager.shared.timeFormatter.string(from: timePicker.date)

        guard
            let title = titleTextField.text,
            let description = descriptionTextView.text
        else { return }

        if selectedIndex == -1 {
            // save button clicked here
            remindersVM.addReminder(title: title, description: description, date: date, time: time)
        } else {
            // update button clicked here
            remindersVM.reminders[selectedIndex].title = title
            remindersVM.reminders[selectedIndex].description = description
            remindersVM.reminders[selectedIndex].date = date
            remindersVM.reminders[selectedIndex].time = time
        }

        remindersVM.saveReminders()

        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
 // MARK: Extensions
extension DetailsVC: UITextFieldDelegate, UITextViewDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
