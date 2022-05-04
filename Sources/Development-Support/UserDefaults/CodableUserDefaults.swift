//
//  CodableUserDefaults.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/15/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

@propertyWrapper
struct CodableUserDefault<T: Codable> {
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
            guard let data = defaults.data(forKey: key) else { return defaultValue }
            return (try? decoder.decode(T.self, from: data)) ?? defaultValue
        }
        set {
            let data = try? encoder.encode(newValue)
            defaults.set(data, forKey: key)
        }
    }

    private var defaults: UserDefaults {
        if let suitName = suitName {
            return UserDefaults(suiteName: suitName) ?? .standard
        } else {
            return .standard
        }
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}

extension CodableUserDefault where T: OptionalProtocol {
    init(key: String, suit: UserDefaultSuit? = nil) {
        self.init(key: key, defaultValue: T(reconstructing: nil), suit: suit)
    }
}
