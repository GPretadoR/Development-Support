//
//  UITextField+Extension.swift
//
//
//  Created by Garnik Ghazaryan on 4/28/24.
//

import Combine
import UIKit

extension UITextField {
    @available(iOS 13.0, *)
    var textChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }
}

extension UITextView {
    @available(iOS 13.0, *)
    var textChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextView)?.text }
        .eraseToAnyPublisher()
    }
}
