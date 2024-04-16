//
//  RemindersModel.swift
//  Reminder
//
//  Created by Türker Kızılcık on 1.02.2024.
//

import Foundation

struct Reminder : Codable {
    var title: String
    var description: String
    var date: String
    var time: String
    var isChecked: Bool
}
