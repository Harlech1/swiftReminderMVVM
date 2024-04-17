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

    var recievedReminder : Reminder?

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

        if recievedReminder != nil {
            loadReminderDetails()
            saveOrUpdateButton.setTitle("update".localized(), for: .normal)
        }

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
