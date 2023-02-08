//
//  Extensions.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/10/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import UIKit

enum FileWriteError: Error {
    case directoryDoesntExist
    case convertToDataIssue
}

public protocol FileWriter {
    var fileName: String { get }
    func write(_ text: String) throws
}

public extension FileWriter {
    var fileName: String { return "File.txt" }

    func write(_ text: String) throws {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileWriteError.directoryDoesntExist
        }

        let encoding = String.Encoding.utf8

        guard let data = text.data(using: encoding) else {
            throw FileWriteError.convertToDataIssue
        }

        let fileUrl = dir.appendingPathComponent(fileName)

        if let fileHandle = FileHandle(forWritingAtPath: fileUrl.path) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        } else {
            try text.write(to: fileUrl, atomically: false, encoding: encoding)
        }
    }
}
