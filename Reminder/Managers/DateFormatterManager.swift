//
//  DateFormatterManager.swift
//  Reminder
//
//  Created by Türker Kızılcık on 8.02.2024.
//

import Foundation

class DateFormatterManager {
    static let shared = DateFormatterManager()

    private init() { }

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
