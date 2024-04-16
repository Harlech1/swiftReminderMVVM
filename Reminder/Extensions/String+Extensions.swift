//
//  String+Extensions.swift
//  Reminder
//
//  Created by Türker Kızılcık on 16.04.2024.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
