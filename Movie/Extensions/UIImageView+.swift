//
//  UIImageView+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/2/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCornerRadius(_ radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
