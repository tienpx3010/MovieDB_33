//
//  AppDelegate.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/27/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set font for tabbar title text
        guard let font = UIFont(name: "SFProDisplay-Regular", size: 10) else {
            return true
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
        return true
    }
}
