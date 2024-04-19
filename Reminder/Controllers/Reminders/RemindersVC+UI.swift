//
//  RemindersVC+UI.swift
//  Reminder
//
//  Created by Türker Kızılcık on 17.04.2024.
//

import UIKit

extension RemindersVC {

    func initTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReminderCell.self, forCellReuseIdentifier: "ReminderCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityLabel = ReminderManager.shared.reminders.isEmpty ? "emptyListAccessibility".localized() : nil
        tableView.accessibilityHint = ReminderManager.shared.reminders.isEmpty ? "emptyListHint".localized() : nil
        return tableView
    }

    func initNoReminderView() -> UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func initNoReminderTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "noReminders".localized()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func initNoReminderSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "noRemindersDetailed".localized()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func addAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill"), style: .plain, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = UIColor.systemOrange
        addButton.accessibilityLabel = "addReminderAccessibility".localized()
        addButton.accessibilityHint = "addReminderHint".localized()
        navigationItem.rightBarButtonItem = addButton
    }

    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(noReminderView)
        view.addSubview(noRemindersTitleLabel)
        view.addSubview(noReminderSubtitleLabel)
    }

    func setNoRemindersView() {
        let isVisible = !tableView.visibleCells.isEmpty
        noReminderView.isHidden = isVisible
        noRemindersTitleLabel.isHidden = isVisible
        noReminderSubtitleLabel.isHidden = isVisible
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            noReminderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noReminderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noReminderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            noReminderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            noRemindersTitleLabel.topAnchor.constraint(equalTo: noReminderView.topAnchor, constant: 8),
            noRemindersTitleLabel.leadingAnchor.constraint(equalTo: noReminderView.leadingAnchor, constant: 48),
            noRemindersTitleLabel.trailingAnchor.constraint(equalTo: noReminderView.trailingAnchor, constant: -48),

            noReminderSubtitleLabel.topAnchor.constraint(equalTo: noRemindersTitleLabel.bottomAnchor, constant: 4),
            noReminderSubtitleLabel.leadingAnchor.constraint(equalTo: noReminderView.leadingAnchor, constant: 48),
            noReminderSubtitleLabel.trailingAnchor.constraint(equalTo: noReminderView.trailingAnchor, constant: -48),
            noReminderSubtitleLabel.bottomAnchor.constraint(equalTo: noReminderView.bottomAnchor, constant: -8),
        ])
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
