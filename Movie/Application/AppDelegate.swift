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
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.sfProDisplayFont(ofSize: 10, weight: .regular)],
            for: UIControl.State.normal)
        return true
    }
}
