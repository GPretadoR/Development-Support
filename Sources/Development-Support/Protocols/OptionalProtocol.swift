//
//  OptionalProtocol.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

public protocol OptionalProtocol {
    /// The type contained in the otpional.
    associatedtype Wrapped

    init(reconstructing value: Wrapped?)

    /// Extracts an optional from the receiver.
    var optional: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    public var optional: Wrapped? {
        return self
    }

    public init(reconstructing value: Wrapped?) {
        self = value
    }
}
