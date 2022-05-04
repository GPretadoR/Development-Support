//
//  UIViewController+Alert.swift
//  ANIV
//
//  Created by Davit Ghushchyan on 6/8/21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

extension UIViewController {
    private func createCancelAction(on alert: UIAlertController, title: String?, style: UIAlertController.Style) {
        guard !(title?.isEmpty ?? true) else { return }
            alert.addAction(UIAlertAction(title: title,
                                          style: style == .alert ? .destructive : .cancel,
                                          handler: nil))
    }
    func showAlert<T: RawRepresentable>(title: String? = nil,
                                        message: String? = nil,
                                        style: UIAlertController.Style = .alert,
                                        closeButtonTitle: String? = "Cancel",
                                        buttonTitles: [String] = [],
                                        buttonAction: ((T) -> Void)? = nil
    )  where T.RawValue == Int {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        for (index, buttonTitle) in buttonTitles.enumerated() {
            if let val = T(rawValue: index) {
                let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
                    buttonAction?(val)
                }
                alert.addAction(action)
            }
        }
        createCancelAction(on: alert, title: closeButtonTitle, style: style)
        present(alert, animated: true, completion: nil)
    }

    func showAlert(title: String? = nil,
                   message: String? = nil,
                   style: UIAlertController.Style = .alert,
                   closeButtonTitle: String? = "Cancel",
                   buttonTitles: [String] = [],
                   buttonAction: ((Int) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, buttonTitle) in buttonTitles.enumerated() {
            let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
                buttonAction?(index)
            }
            alert.addAction(action)
        }
        createCancelAction(on: alert, title: closeButtonTitle, style: style)
        present(alert, animated: true, completion: nil)
    }

    func showAlert(title: String? = nil,
                   message: String? = nil,
                   style: UIAlertController.Style = .alert,
                   closeButtonTitle: String? = "Cancel",
                   buttonTitles: [String] = [],
                   buttonAction: ((String, Int) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, buttonTitle) in buttonTitles.enumerated() {
            let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
                buttonAction?(buttonTitle, index)
            }
            alert.addAction(action)
        }
        createCancelAction(on: alert, title: closeButtonTitle, style: style)
        present(alert, animated: true, completion: nil)
    }
}
