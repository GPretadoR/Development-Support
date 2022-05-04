//
//  PropertyIteratable.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/15/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

public protocol PropertyIteratable {
    func allProperties() throws -> [String: Any]
}

public extension PropertyIteratable {
    func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        guard let style = mirror.displayStyle, style == Mirror.DisplayStyle.struct || style == Mirror.DisplayStyle.class else {
            throw NSError(domain: "Cannot get style", code: 555, userInfo: nil)
        }

        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }

            result[label] = valueMaybe
        }

        return result
    }
}

public protocol PropertyReflectable { }

public extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}
