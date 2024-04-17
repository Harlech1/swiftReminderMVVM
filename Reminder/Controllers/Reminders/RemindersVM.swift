//
//  RemindersVM.swift
//  Reminder
//
//  Created by Türker Kızılcık on 1.02.2024.
//

import UserNotifications

class RemindersVM {
    var reminders = ReminderManager.shared.reminders

    func initNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        for reminder in reminders {
            scheduleNotification(for: reminder)
        }
    }

    func scheduleNotification(for reminder: Reminder) {
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
}
