//
//  Date.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 1/8/2566 BE.
//

import Foundation

extension Date {
    func toStringDisplayDate(format: String = formatDateNewsDisplay) -> String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
