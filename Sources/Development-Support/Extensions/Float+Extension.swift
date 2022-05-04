//
//  Float+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

extension Double {
    var toMeters: Int {
        return Int(self * 1000)
    }

    var toKiloMeters: Double {
        return self / 1000.0
    }

    var toFormattedKM: String {
        String(format: "%.02f", self.toKiloMeters)
    }

    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func dropDecimalsAfter(amountOfDecimals: Int) -> Double? {
        let stringValue = String(format: "%.\(amountOfDecimals)f", self)
        return Double(stringValue)
    }

    var toRadians: Double { return self * .pi / 180 }
    var toDegrees: Double { return self * 180 / .pi }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension CGFloat {
    var toRadians: CGFloat { return self * .pi / 180 }
    var toDegrees: CGFloat { return self * 180 / .pi }
}

extension String {
    var cleanNumber: String {
        Double(self)?.clean ?? ""
    }
}
