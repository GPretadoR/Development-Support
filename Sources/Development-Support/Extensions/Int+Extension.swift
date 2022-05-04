//
//  Int+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

extension Int {
    var toTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
    }

    var toLabeledTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1dh %02dm %02ds", h, m, s) : String(format: "%02dm %02ds", m, s)
    }

    var toKiloMeters: Double {
        return Double(self) / 1000.0
    }

    var toFormattedKM: String {
        String(format: "%.02f", self.toKiloMeters)
    }

    var minutes: DateComponents {
        var comps = DateComponents()
        comps.minute = self
        return comps
    }

    var hours: DateComponents {
        var comps = DateComponents()
        comps.hour = self
        return comps
    }

    var days: DateComponents {
        var comps = DateComponents()
        comps.day = self
        return comps
    }

    var weeks: DateComponents {
        var comps = DateComponents()
        comps.day = 7 * self
        return comps
    }

    var months: DateComponents {
        var comps = DateComponents()
        comps.month = self
        return comps
    }

    var years: DateComponents {
        var comps = DateComponents()
        comps.year = self
        return comps
    }
}

extension UInt {
    var toTimeStamp: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
    }

    var toKiloMeters: Double {
        return Double(self) / 1000.0
    }
}
