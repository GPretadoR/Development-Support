//
//  UserDefault.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/15/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let suitName: String?

    init(key: String, defaultValue: T, suit: UserDefaultSuit? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        self.suitName = suit?.name
    }

    var wrappedValue: T {
        get {
            if let value = defaults.object(forKey: key) as? T {
                return value
            } else {
                self.wrappedValue = defaultValue
                return defaultValue
            }
        }
        nonmutating set {
            defaults.set(newValue, forKey: key)
        }
    }

    private var defaults: UserDefaults {
        if let suitName = suitName {
            return UserDefaults(suiteName: suitName) ?? .standard
        } else {
            return .standard
        }
    }
}

extension UserDefault where T: OptionalProtocol {
    init(key: String, suit: UserDefaultSuit? = nil) {
        self.init(key: key, defaultValue: T(reconstructing: nil), suit: suit)
    }
}
