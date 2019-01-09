//
//  UIFont+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import UIKit

enum FontWeight: String {
    case ultraLight = "UltraLight"
    case thin = "Thin"
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "SemiBold"
    case bold = "Bold"
    case heavy = "Heavy"
    case black = "Black"
}

extension UIFont {
    static func sfProDisplayFont(ofSize fontSize: CGFloat, weight: FontWeight) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-" + weight.rawValue, size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return font
    }
}
