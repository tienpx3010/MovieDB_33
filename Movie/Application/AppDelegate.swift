//
//  AppDelegate.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/27/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        // Set font for tabbar title text
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.sfProDisplayFont(ofSize: 10, weight: .regular)],
            for: UIControl.State.normal)
        // Configure Audio Session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(.playback,
                                                                mode: .moviePlayback,
                                                                options: .defaultToSpeaker)
            }
        } catch let error as NSError {
            print(error)
        }
//        let storyboard:UIStoryboard = UIStoryboard(name: "Movie", bundle: nil)
//        let rootViewController = storyboard.instantiateViewController(
//            withIdentifier: "PersonViewController") as UIViewController
//        self.window?.rootViewController = rootViewController
        return true
    }
}
