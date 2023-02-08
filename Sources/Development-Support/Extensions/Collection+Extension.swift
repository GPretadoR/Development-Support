//
//  Collection+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

public extension Collection {
    var nonEmpty: Self? {
        return isEmpty ? nil : self
    }
    
    func element(at index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

public extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
    func diff(from other: [Element]) -> [Element] {
        var result: [Element] = []
        self.forEach { element in
            if !other.contains(element) {
                result.append(element)
            }
        }
        other.forEach { otherElement in
            if !self.contains(otherElement) {
                result.append(otherElement)
            }
        }
        return result
    }
}

public extension Dictionary {
    func toObject<T: Decodable>(decodeType: T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        guard let json = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return json
    }
    
    func toData() -> Data? where Key: Encodable, Value: Encodable {
        let data = try? JSONEncoder().encode(self)
        return data
    }
}

public extension CharacterSet {
    static func isLettersOnly(text: String) -> Bool {
        let set = CharacterSet(charactersIn: "0123456789!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢՜՝։…՛★–«»՚՞")
        if text.rangeOfCharacter(from: set) != nil {
            return false
        }
        return true
    }
}

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
