//
//  ReminderManager.swift
//  Reminder
//
//  Created by Türker Kızılcık on 17.04.2024.
//

import Foundation

class ReminderManager {
    static let shared = ReminderManager()

    var reminders: [Reminder] = []

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init() {
        loadReminders()
    }

    func addReminder(title: String, description: String, date: String, time: String) {
        let newReminder = Reminder(title: title, description: description, date: date, time: time, isChecked: false)
        reminders.append(newReminder)
    }

    func saveReminders() {
        if let encodedData = try? encoder.encode(reminders) {
            UserDefaults.standard.set(encodedData, forKey: "reminders")
        }
    }

    func loadReminders() {
        if let remindersData = UserDefaults.standard.data(forKey: "reminders") {
            if let decodedReminders = try? decoder.decode([Reminder].self, from: remindersData) {
                reminders = decodedReminders
            }
        }
    }

    func deleteReminder(at index: Int) {
        guard index < reminders.count else { return }
        reminders.remove(at: index)
    }
}
