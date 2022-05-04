//
//  UIImage+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func scaledWithMaxWidthOrHeightValue(value: CGFloat) -> UIImage? {
        let width = size.width
        let height = size.height

        let ratio = width / height

        var newWidth = value
        var newHeight = value

        if ratio > 1 {
            newWidth = width * (newHeight / height)
        } else {
            newHeight = height * (newWidth / width)
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0)

        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func scaled(withScale scale: CGFloat) -> UIImage? {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }

    func merge(image: UIImage, atRect: CGRect, margin: CGSize, vertically: Bool) -> UIImage {
        let topImage = self
        let bottomImage = image

        let selfSize = self.size

        var size = CGSize.zero
        if vertically {
            size = CGSize(width: selfSize.width, height: selfSize.height + atRect.size.height + margin.height)
        } else {
            size = CGSize(width: selfSize.width + atRect.size.width + margin.width, height: selfSize.height)
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        topImage.draw(in: CGRect(x: 0, y: 0, width: selfSize.width, height: selfSize.height))

        bottomImage.draw(in: atRect, blendMode: .normal, alpha: 1)

        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}

enum ImageEncodingQuality {
    case png
    case jpeg(quality: Double)
}

enum ImageDecodingError: Error {
    case decodeError
}

extension KeyedEncodingContainer {

    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key,
                         quality: ImageEncodingQuality = .png) throws {
        var imageData: Data!
        switch quality {
        case .png:
            imageData = value.pngData()
        case .jpeg(let quality):
            imageData = value.jpegData(compressionQuality: CGFloat(quality))
        }
        try encode(imageData, forKey: key)
    }

}

extension KeyedDecodingContainer {
    public func decode(_ type: UIImage.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw ImageDecodingError.decodeError
        }
    }
}
