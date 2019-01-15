//
//  CustomImageView.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    override open func layoutSubviews() {
        sd_setShowActivityIndicatorView(true)
        sd_setIndicatorStyle(.gray)
    }
}
