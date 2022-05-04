//
//  NSAttributedString+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {
    // Set part of string as URL
    func setSubstringAsLink(substring: String, linkURL: String) -> Bool {
        let range = mutableString.range(of: substring)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.link, value: linkURL, range: range)
            return true
        }
        return false
    }
}
