//
//  String.swift
//  AssignmentSCG
//
//  Created by Papon Supamongkonchai on 1/8/2566 BE.
//

import Foundation



extension String {
    func toDate(format: String = formatDateTime) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateNewsDisplay() -> String {
        if let date = self.toDate() {
            return date.toStringDisplayDate()
        } else {
            return ""
        }
    }
}
