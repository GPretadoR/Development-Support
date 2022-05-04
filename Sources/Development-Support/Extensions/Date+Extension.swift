//
//  Date+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

public extension Date {
    /// Example: 29-12-2020
    static var dateFormatddMMyyyy: String {
        return "dd-MM-yyyy"
    }

    /// Example: 29-12-88
    static var dateFormatddMMyy: String {
        return "dd-MM-yy"
    }

    /// Example: 29/12/2020
    static var dateFormatddMMyyyySlashed: String {
        return "dd/MM/yyyy"
    }

    /// Example: 29/12/2020 23:59:59
    static var dateFormatddMMyyyySlashedAndTime: String {
        return "dd/MM/yyyy HH:mm:ss"
    }

    /// Example: 29/12/88
    static var dateFormatddMMyySlashed: String {
        return "dd/MM/yy"
    }

    /// Example: Dec 29, 2020
    static var dateFormatMMMddyyTextual: String {
        return "MMM dd, yyyy"
    }

    /// Example: 12.02.2020 02:45PM
    static var dateFormatMMddyyyyHoursDotted: String {
        return "dd.MM.yyyy HH:mm a"
    }

    /// Example  2021-06-17T21:05:08.319Z
    static var dateFormatFull: String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }

    static var timeFormatFull: String {
        return "HH:mm:ss.SSSZ"
    }

    static func stringDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    static func stringFrom(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    static func dateFrom(string stringDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: stringDate)
    }

    static func dateFrom(string stringDate: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.date(from: stringDate)
    }

    static func dateString(fromDateString: String, fromFormat: String, toFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat
        formatter.locale = Locale.current
        guard let date = formatter.date(from: fromDateString) else { return nil }
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }

    static func formattedTime(timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm:ss"
        let time: Date = formatter.date(from: timeString)!
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }

    private func randomNumberBetween(top: Double, bottom: Double) -> Double {
        var range = top - bottom
        if bottom > top {
            range = bottom - top
        }
        return Double(arc4random()) / Double(UINT32_MAX) * range
    }

    // Date + DateComponents
    static func + (_ lhs: Date, _ rhs: DateComponents) -> Date {
        return Calendar.current.date(byAdding: rhs, to: lhs)!
    }

    // DateComponents + Dates
    static func + (_ lhs: DateComponents, _ rhs: Date) -> Date {
        return rhs + lhs
    }

    // Date - DateComponents
    static func - (_ lhs: Date, _ rhs: DateComponents) -> Date {
        return lhs + (-rhs)
    }

    static func - (_ lhs: Date, _ rhs: Date) -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                               from: rhs,
                                               to: lhs)
    }
}

public extension DateComponents {
    var fromNow: Date {
        return Calendar.current.date(byAdding: self,
                                     to: Date())!
    }

    var ago: Date {
        return Calendar.current.date(byAdding: -self,
                                     to: Date())!
    }

    static func + (_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
        return DateComponents.combineComponents(lhs, rhs)
    }

    static func - (_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
        return DateComponents.combineComponents(lhs, rhs, multiplier: -1)
    }

    static func combineComponents(_ lhs: DateComponents, _ rhs: DateComponents, multiplier: Int = 1) -> DateComponents {
        var result = DateComponents()
        result.second = (lhs.second ?? 0) + (rhs.second ?? 0) * multiplier
        result.minute = (lhs.minute ?? 0) + (rhs.minute ?? 0) * multiplier
        result.hour = (lhs.hour ?? 0) + (rhs.hour ?? 0) * multiplier
        result.day = (lhs.day ?? 0) + (rhs.day ?? 0) * multiplier
        result.weekOfYear = (lhs.weekOfYear ?? 0) + (rhs.weekOfYear ?? 0) * multiplier
        result.month = (lhs.month ?? 0) + (rhs.month ?? 0) * multiplier
        result.year = (lhs.year ?? 0) + (rhs.year ?? 0) * multiplier
        return result
    }

    static prefix func - (components: DateComponents) -> DateComponents {
        var result = DateComponents()
        if components.second != nil { result.second = -components.second! }
        if components.minute != nil { result.minute = -components.minute! }
        if components.hour != nil { result.hour = -components.hour! }
        if components.day != nil { result.day = -components.day! }
        if components.weekOfYear != nil { result.weekOfYear = -components.weekOfYear! }
        if components.month != nil { result.month = -components.month! }
        if components.year != nil { result.year = -components.year! }
        return result
    }
}
