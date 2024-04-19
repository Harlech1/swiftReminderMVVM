//
//  DetailsViewController.swift
//  Reminder
//
//  Created by Türker Kızılcık on 2.02.2024.
//

import UIKit

class DetailsVC: UIViewController  {
    lazy var titleTextField = initTitleTextField()
    lazy var descriptionTextView = initDescriptionTextView()
    lazy var placeholderLabel = initPlaceholderLabel()
    lazy var dateStackView = initDateStackView()
    lazy var timeStackView = initTimeStackView()
    lazy var dateLabel = initDateLabel()
    lazy var timeLabel = initTimeLabel()
    lazy var datePicker = initDatePicker()
    lazy var timePicker = initTimePicker()
    lazy var saveOrUpdateButton = initSaveOrUpdateButton()

    let toolbar = UIToolbar()

    var receivedReminder : Reminder?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGroupedBackground

        title = "details".localized()
        
        addSubviews()
        setupKeyboardDismissGesture()
        setupToolbar()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        guard receivedReminder != nil else { return }

        updateReminderUI()
    }

    @objc func saveOrUpdateButtonTapped() {
        guard
            let title = titleTextField.text,
            let description = descriptionTextView.text
        else { return }

        let date = DateFormatterManager.shared.dateFormatter.string(from: datePicker.date)
        let time = DateFormatterManager.shared.timeFormatter.string(from: timePicker.date)

        if receivedReminder == nil {
            ReminderManager.shared.addReminder(title: title, description: description, date: date, time: time)
        } else {
            if let index = ReminderManager.shared.reminders.firstIndex(where: { $0 == receivedReminder }) {
                ReminderManager.shared.reminders[index].title = title
                ReminderManager.shared.reminders[index].description = description
                ReminderManager.shared.reminders[index].date = date
                ReminderManager.shared.reminders[index].time = time
            }
        }

        ReminderManager.shared.saveReminders()

        self.navigationController?.popViewController(animated: true)
    }

    func loadReminderDetails() {
        guard
            let dateString = receivedReminder?.date,
            let timeString = receivedReminder?.time,
            let date = DateFormatterManager.shared.dateFormatter.date(from: dateString),
            let time = DateFormatterManager.shared.timeFormatter.date(from: timeString)
        else { return }

        titleTextField.text = receivedReminder?.title
        descriptionTextView.text = receivedReminder?.description

        datePicker.date = date
        timePicker.date = time
    }

    func updateReminderUI() {
        saveOrUpdateButton.setTitle("update".localized(), for: .normal)
        loadReminderDetails()
        placeholderLabel.isHidden = !descriptionTextView.text.isEmpty
    }
}

 // MARK: - UITextFieldDelegate, UITextViewDelegate
extension DetailsVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
