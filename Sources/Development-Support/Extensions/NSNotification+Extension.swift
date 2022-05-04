//
//  NSNotification+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let ViewDidLoad = Notification.Name("ViewDidLoad")
    static let ViewWillAppear = Notification.Name("viewWillAppear")
    static let ViewDidAppear = Notification.Name("viewDidAppear")
    static let ViewWillDisappear = Notification.Name("viewWillDisappear")
    static let ViewDidDisappear = Notification.Name("viewDidDisappear")

    static let PaymentCompleted = Notification.Name("paymentCompleted")
    static let PaymentWithStripeCompleted = Notification.Name("paymentWithStripeCompleted")
    static let PaymentWithApplePayCompleted = Notification.Name("paymentWithApplePayCompleted")
}
