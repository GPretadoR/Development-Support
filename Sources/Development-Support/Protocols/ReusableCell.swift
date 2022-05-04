//
//  ReusableCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//
import UIKit
// swiftlint:disable force_cast
public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableCell {
    public static var reuseIdentifier: String {
        return NSStringFromClass(Self.self)
    }
}

public extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionViewCell: ReusableCell {
    public static var reuseIdentifier: String {
        return NSStringFromClass(Self.self)
    }
}

public extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
