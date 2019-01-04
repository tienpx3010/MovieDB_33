//
//  Colors.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/28/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import ChameleonFramework

struct Colors {
    private static let mixColors: [UIColor] = [
        HexColor("F99F00")!,
        HexColor("DB3069")!
    ]
    public static let tabBarGradientColor = GradientColor(.leftToRight,
                                                          frame: CGRect.init(x: 0, y: 0, width: 80, height: 20),
                                                          colors: mixColors)
}
