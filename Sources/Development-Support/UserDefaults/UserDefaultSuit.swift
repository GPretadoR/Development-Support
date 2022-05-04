//
//  UserDefaultSuit.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/15/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

struct UserDefaultSuit {
    let name: String
}

extension UserDefaultSuit {
    static let common = UserDefaultSuit(name: "Common")
}
