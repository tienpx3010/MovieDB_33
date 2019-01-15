//
//  BaseViewController.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/13/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Then
import SnapKit

class BaseViewController: UIViewController {
    var titleLabel = UILabel()
    
    private struct Constants {
        static let barHeight: CGFloat = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
    }
    
    private func configNavigation() {
        guard let navigationController = navigationController, let title = tabBarItem.title else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        let barView = UIView()
        navigationController.navigationBar.addSubview(barView)
        barView.do {
            let superview = navigationController.navigationBar
            let width = Screen.width
            let height = Constants.barHeight + Screen.statusBarHeight
            $0.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(width)
                make.height.equalTo(height)
                make.top.equalTo(superview).offset(-Screen.statusBarHeight)
                make.left.equalTo(superview)
            }
            $0.backgroundColor = UIColor.gradientColor(width: width, height: height)
        }
        titleLabel.do {
            $0.text = title
            $0.textColor = .white
            $0.font = UIFont.sfProDisplayFont(ofSize: 24, weight: .bold)
        }
        barView.addSubview(titleLabel)
        titleLabel.do {
            $0.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(Screen.width / 2)
                make.height.equalTo(60)
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(20)
            }
        }
        let searchButton = UIButton().then {
            $0.setTitle("", for: .normal)
            $0.setImage(#imageLiteral(resourceName: "icon_search"), for: .normal)
            $0.addTarget(self, action: #selector(toggleSearch), for: .touchUpInside)
        }
        barView.addSubview(searchButton)
        searchButton.do {
            $0.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(40)
                make.height.equalTo(40)
                make.centerY.equalTo(titleLabel.snp.centerY)
                make.right.equalToSuperview().offset(-20)
            }
        }
    }
    
    @objc func toggleSearch(sender: UIButton!) {
        sender.animate()
        let searchViewController = SearchViewController.instantiate()
        present(searchViewController, animated: false, completion: nil)
    }
}
