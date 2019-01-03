//
//  ViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/27/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController, BWWalkthroughViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch {
            showWalkthrough()
        }
    }

    func showWalkthrough() {
        // Build the walkthrough
        let walkthroughStoryBoard = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthroughViewController = walkthroughStoryBoard.instantiateViewController(withIdentifier: "walk") as! BWWalkthroughViewController
        let pageOne = walkthroughStoryBoard.instantiateViewController(withIdentifier: "walk0")
        let pageTwo = walkthroughStoryBoard.instantiateViewController(withIdentifier: "walk1")
        let pageThree = walkthroughStoryBoard.instantiateViewController(withIdentifier: "walk2")

        // Add pages
        walkthroughViewController.add(viewController: pageOne)
        walkthroughViewController.add(viewController: pageTwo)
        walkthroughViewController.add(viewController: pageThree)
        walkthroughViewController.delegate = self

        // Show walkthrough
        self.present(walkthroughViewController, animated: false, completion: nil)
    }

    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: false, completion: nil)
    }
}
