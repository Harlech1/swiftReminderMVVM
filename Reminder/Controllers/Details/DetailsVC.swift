//
//  DetailsViewController.swift
//  Reminder
//
//  Created by Türker Kızılcık on 2.02.2024.
//

import UIKit

class DetailsVC: UIViewController  {

    let remindersVM = RemindersVM()

    var selectedIndex = -1 // TODO: here

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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGroupedBackground

        title = "details".localized()
        
        addSubviews()
        addTapGesture()
        setupToolbar()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if selectedIndex != -1 { // TODO: here
            loadReminderDetails()   
            saveOrUpdateButton.setTitle("update".localized(), for: .normal)
        }

        placeholderLabel.isHidden = !descriptionTextView.text.isEmpty
    }
    
    // MARK: @Objc Functions
    @objc func saveOrUpdateButtonTapped() {
        let date = DateFormatterManager.shared.dateFormatter.string(from: datePicker.date)
        let time = DateFormatterManager.shared.timeFormatter.string(from: timePicker.date)

        guard
            let title = titleTextField.text,
            let description = descriptionTextView.text
        else { return }

        if selectedIndex == -1 {
            // save button clicked here
            ReminderManager.shared.addReminder(title: title, description: description, date: date, time: time)
        } else {
            // update button clicked here
            ReminderManager.shared.reminders[selectedIndex].title = title
            ReminderManager.shared.reminders[selectedIndex].description = description
            ReminderManager.shared.reminders[selectedIndex].date = date
            ReminderManager.shared.reminders[selectedIndex].time = time
        }

        ReminderManager.shared.saveReminders()

        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
 // MARK: - Privates
private extension DetailsVC {
    func loadReminderDetails() {
        titleTextField.text = ReminderManager.shared.reminders[selectedIndex].title
        descriptionTextView.text = ReminderManager.shared.reminders[selectedIndex].description

        let dateString = ReminderManager.shared.reminders[selectedIndex].date
        let timeString = ReminderManager.shared.reminders[selectedIndex].time

        guard
            let date = DateFormatterManager.shared.dateFormatter.date(from: dateString),
            let time = DateFormatterManager.shared.timeFormatter.date(from: timeString)
        else { return }

        datePicker.date = date
        timePicker.date = time
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
