//
//  HomeViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/27/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import BWWalkthrough
import ChameleonFramework

final class HomeViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }

    private func configView() {
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch {
            showWalkthrough()
        }
        tabBar.tintColor = UIColor.tabBarGradientColor
    }

    private func showWalkthrough() {
        let walkthroughViewController = BWWalkthroughViewController.instantiate()
        // Build the walkthrough
        let pageOne = Storyboards.walkthrough.instantiateViewController(withIdentifier: "walkthroughPageVC01")
        let pageTwo = Storyboards.walkthrough.instantiateViewController(withIdentifier: "walkthroughPageVC02")
        let pageThree = Storyboards.walkthrough.instantiateViewController(withIdentifier: "walkthroughPageVC03")
        // Add pages
        walkthroughViewController.add(viewController: pageOne)
        walkthroughViewController.add(viewController: pageTwo)
        walkthroughViewController.add(viewController: pageThree)
        walkthroughViewController.delegate = self
        // Show walkthrough
        present(walkthroughViewController, animated: false, completion: nil)
    }
}

extension HomeViewController: BWWalkthroughViewControllerDelegate {
    func walkthroughCloseButtonPressed() {
        dismiss(animated: false, completion: nil)
    }
}
