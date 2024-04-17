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

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
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
