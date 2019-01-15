//
//  UIColor+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/4/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import ChameleonFramework

extension UIColor {
    private static var mixColors: [UIColor] {
        guard let firstColor = HexColor("F99F00"), let secondColor = HexColor("DB3069") else {
            return []
        }
        return [firstColor, secondColor]
    }
    static let firstGradientColor = GradientColor(.leftToRight,
                                                          frame: CGRect(x: 0, y: 0, width: 80, height: 20),
                                                          colors: mixColors)
    static let secondGradientColor = GradientColor(.topToBottom,
                                                         frame: CGRect(x: 0, y: 0, width: 30, height: 30),
                                                         colors: mixColors)
    static func gradientColorForView(view: UIView) -> UIColor {
        return GradientColor(.leftToRight,
                              frame: CGRect(x: 0, y: 0,
                                            width: view.frame.width * Screen.ratioWidth,
                                            height: view.frame.height * Screen.ratioHeight),
                              colors: mixColors)
    }
    static func gradientColor(width: CGFloat, height: CGFloat) -> UIColor {
        return GradientColor(.leftToRight,
                             frame: CGRect(x: 0, y: 0,
                                           width: width,
                                           height: height),
                             colors: mixColors)
    }
}
