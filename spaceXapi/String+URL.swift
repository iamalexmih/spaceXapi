//
//  String+URL.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation


extension String {
    // формат даты ДД-ММ-ГГГГ
    func convertDate() -> String {
        let dateFormatterISO8601 = ISO8601DateFormatter()
        dateFormatterISO8601.formatOptions.insert(.withFractionalSeconds)
        let date = dateFormatterISO8601.date(from: self)
        guard let date = date else { return "N/A" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
}
