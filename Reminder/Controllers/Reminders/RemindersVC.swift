//
//  ViewController.swift
//  Reminder
//
//  Created by Türker Kızılcık on 1.02.2024.
//

import UIKit

class RemindersVC: UIViewController, UITableViewDataSource {

    private let remindersVM = RemindersVM()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReminderCell.self, forCellReuseIdentifier: "ReminderCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityLabel = ReminderManager.shared.reminders.isEmpty ? "emptyListAccessibility".localized() : nil
        tableView.accessibilityHint = ReminderManager.shared.reminders.isEmpty ? "emptyListHint".localized() : nil
        return tableView
    }()

    let containerView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let upperLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "noReminders".localized()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lowerLabel: UILabel = {
        let label = UILabel()
        label.text = "noRemindersDetailed".localized()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var selectedReminder : Reminder?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "reminders".localized()

        addSubviews()
        addAddButton()
        setUpConstraints()
    }

    // MARK: Override Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        ReminderManager.shared.loadReminders()
        tableView.reloadData()

        setNoRemindersView()

        remindersVM.initNotifications()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.recievedReminder = selectedReminder
        }
    }
}
// MARK: - UITableViewDelegate
extension RemindersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderManager.shared.reminders.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedReminder = ReminderManager.shared.reminders[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? ReminderCell else { return ReminderCell() }

        let reminder = ReminderManager.shared.reminders[indexPath.row]
        cell.configure(reminder: reminder)

        cell.checkBoxAction = {
            ReminderManager.shared.deleteReminder(at: indexPath.row)
            ReminderManager.shared.saveReminders()
            tableView.reloadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
