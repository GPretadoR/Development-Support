//
//  String+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func toObject<T: Decodable>(decodeType: T.Type) -> T? {
        if let data = self.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(decodeType, from: data)
                return object
            } catch {
                return nil
            }
        }
        return nil
    }

    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }

    func splitWord() -> [String] {
        var result = [String]()
        var temp = self
        var done = false
        while !done {
            if let index = temp.lastIndex(where: { $0.isUppercase }) {
                result.insert(String(temp[index...]), at: 0)
                temp = String(temp[..<index])
                done = temp.distance(from: temp.startIndex, to: index) == 0
            } else {
                result.insert(temp, at: 0)
                done = true
            }
        }
        return result
    }
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var results: [Range<Index>] = []
        while let range = range(of: substring,
                                options: options,
                                range: (results.last?.upperBound ?? startIndex)..<endIndex,
                                locale: locale) {
            results.append(range)
        }
        return results
    }

    func nsRanges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        ranges(of: substring, options: options, locale: locale).map { $0.nsRange(in: self) }
    }

    func removeAfter(character: String) -> String {
        let components = components(separatedBy: character)
        return components.first ?? ""
    }
}

private extension RangeExpression where Bound == String.Index {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange {
        NSRange(self, in: string)
    }
}

// MARK: - HTML

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data,
                                       options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }

    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
}
