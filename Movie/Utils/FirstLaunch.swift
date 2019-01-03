//
//  FirstLaunch.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/3/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

final class FirstLaunch {
    let userDefaults: UserDefaults = .standard
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }

    init() {
        let key = "wasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
}
