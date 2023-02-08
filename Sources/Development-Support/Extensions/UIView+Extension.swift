//
//  UIView+Extension.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 14.03.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

public protocol ViewBuilder: AnyObject {}

public extension UIView {

    var ancestors: AnyIterator<UIView> {
        var current: UIView = self

        return AnyIterator<UIView> {
            guard let parent = current.superview else {
                return nil
            }
            current = parent
            return parent
        }
    }

    @available(iOS 10.0, *)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    @available(iOS 10.0, *)
    func asImageSnapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { _ in
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }

    @available(iOS 10.0, *)
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func addCornerRadiusAndShadow(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float) {
        layer.cornerRadius = cornerRadius
        if shadowColor != .clear {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
        }
    }

    @available(iOS 11.0, *)
    func addShadow(cornerRadius: CGFloat, maskedCorners: CACornerMask, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        if color != .clear {
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOffset = offset
            self.layer.shadowOpacity = opacity
            self.layer.shadowRadius = shadowRadius
        }
    }

    func addCornerRadius(cornerRadius: CGFloat) {
        self.addCornerRadiusAndShadow(cornerRadius: cornerRadius, shadowColor: .clear, shadowOffset: .zero, shadowRadius: .zero, shadowOpacity: .zero)
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners.caCornerMask
    }

    class func instanceFromNib(name: String) -> UIView {
        guard let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { return UIView() }
        return view
    }

    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { self.addSubview($0) }
    }

    func rotate(duration: CFTimeInterval, repeatCount: Float) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = repeatCount
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    func allSubviews(with tag: Int) -> [UIView] {
        var taggedSubviews = [UIView]()
        for view in subviews {
            taggedSubviews.append(contentsOf: view.allSubviews(with: tag))
            if view.tag == tag {
                taggedSubviews.append(view)
            }
        }
        return taggedSubviews
    }

    func embed(view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                                     view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
                                     view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
                                     view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)])
    }

    func ancestor<ViewType: UIView>(of type: ViewType.Type) -> ViewType? {
        if let matchingView = self.superview as? ViewType {
            return matchingView
        } else {
            return superview?.ancestor(of: type)
        }
    }

    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}

extension UIView: ViewBuilder {}

public extension ViewBuilder where Self: UIView {
    init(builder: (Self) -> Void) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        builder(self)
    }
}

public extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

extension UIRectCorner {
    
    /// convert UIRectCorner to CACornerMask
    var caCornerMask: CACornerMask {
        var cornersMask = CACornerMask()
        if self.contains(.topLeft) {
            cornersMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornersMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornersMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornersMask.insert(.layerMaxXMaxYCorner)
        }
        return cornersMask
    }
}
