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
    
    var selectedReminder : Reminder?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        title = "reminders".localized()

        addAddButton()
        setUpConstraints()
    }

    // MARK: Private Functions
    private func addAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = UIColor.systemOrange
        addButton.accessibilityLabel = "addReminderAccessibility".localized()
        addButton.accessibilityHint = "addReminderHint".localized()
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "\("reminderFor".localized()) \(reminder.title)"
        content.body = reminder.description

        guard
            let date = DateFormatterManager.shared.dateFormatter.date(from: reminder.date),
            let time = DateFormatterManager.shared.timeFormatter.date(from: reminder.time)
        else { return }

        var triggerComponents = DateComponents()
        let calendar = Calendar.current

        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)

        triggerComponents.day = dateComponents.day
        triggerComponents.month = dateComponents.month
        triggerComponents.year = dateComponents.year
        triggerComponents.hour = timeComponents.hour
        triggerComponents.minute = timeComponents.minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)

        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Couldn't create a reminder, error: \(error.localizedDescription)")
            } else {
                print("Notification created successfully.")
            }
        }
    }

    // MARK: Override Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        ReminderManager.shared.loadReminders()
        tableView.reloadData()

        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        for reminder in ReminderManager.shared.reminders {
            scheduleNotification(for: reminder)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.recievedReminder = selectedReminder
        }
    }

    // MARK: Objc Functions
    @objc func addButtonTapped() {
        chosenIndex = -1
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
// MARK: - Table View Extension
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
