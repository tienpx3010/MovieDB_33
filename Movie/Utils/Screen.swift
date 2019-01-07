//
//  Util.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/5/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import UIKit

struct Screen {
    private static let bounds = UIScreen.main.bounds
    static let width = bounds.size.width
    static let height = bounds.size.height
    static let designWidth: CGFloat = 375
    static let designHeight: CGFloat = 667
    static let ratioWidth = width / designWidth
    static let ratioHeight = height / designHeight
}
