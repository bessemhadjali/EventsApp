//
//  Date+extensions.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 18/10/2020.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentFormatter.unitsStyle = .full
        return dateComponentFormatter.string(from: self, to: endDate)
    }

}
