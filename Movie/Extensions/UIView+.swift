//
//  UIImageView+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/2/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func animate() {
        let scale = CASpringAnimation(keyPath: "transform.scale").then {
            $0.duration = 0.6
            $0.fromValue = 0.95
            $0.toValue = 1.0
        }
        layer.add(scale, forKey: "scale")
    }
}

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
