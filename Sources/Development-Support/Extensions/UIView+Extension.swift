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
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.shadowColor = UIColor.black.cgColor
        mask.shadowOffset = CGSize(width: 6.0, height: 6.0)
        mask.shadowOffset = CGSize(width: 50.0, height: 50.0)
        mask.fillColor = UIColor.red.cgColor
        layer.mask = mask
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
