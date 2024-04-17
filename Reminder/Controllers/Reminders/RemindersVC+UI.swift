//
//  RemindersVC+UI.swift
//  Reminder
//
//  Created by Türker Kızılcık on 17.04.2024.
//

import UIKit

extension RemindersVC {
    
    func addAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill"), style: .plain, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = UIColor.systemOrange
        addButton.accessibilityLabel = "addReminderAccessibility".localized()
        addButton.accessibilityHint = "addReminderHint".localized()
        navigationItem.rightBarButtonItem = addButton
    }

    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(containerView)
        view.addSubview(upperLabel)
        view.addSubview(lowerLabel)
    }

    func setNoRemindersView() {
        let isVisible = !tableView.visibleCells.isEmpty
        containerView.isHidden = isVisible
        upperLabel.isHidden = isVisible
        lowerLabel.isHidden = isVisible
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            upperLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            upperLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 48),
            upperLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48),

            lowerLabel.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 4),
            lowerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 48),
            lowerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48),
            lowerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }
    
    @objc func addButtonTapped() {
        selectedReminder = nil
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
