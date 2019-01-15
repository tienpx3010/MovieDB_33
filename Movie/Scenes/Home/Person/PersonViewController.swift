//
//  PersonViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/15/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Then
import SnapKit

class PersonViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var separator = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configView()
    }

    private func configView() {
        let height = headerView.frame.height + tabView.frame.height
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.darkGray
        tableView.allowsSelection = true
        let stackView = UIStackView().then {
            $0.frame = CGRect(x: 0, y: 0, width: tabView.frame.width, height: tabView.frame.height)
            $0.distribution = .fillEqually
            $0.axis = .horizontal
        }
        tabView.addSubview(stackView)
        // Create Tab Button
        for index in 1...3 {
            createTabButtonView(count: index, text: "Tien", stackView: stackView)
        }
        // Create Indicator View
        separator.do {
            $0.layer.cornerRadius = 2
            $0.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.09411764706, blue: 0.1647058824, alpha: 1)
        }
        tabView.addSubview(separator)
        separator.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(4)
            make.bottom.equalTo(tabView.snp.bottom).offset(10)
            make.centerX.equalTo(stackView.subviews[0].snp.centerX)
        }
    }

    private func createTabButtonView(count: Int, text: String, stackView: UIStackView) {
        let view = UIView().then {
            $0.frame = CGRect(x: 0, y: 0, width: stackView.frame.width / 3, height: stackView.frame.height)
            $0.backgroundColor = .yellow
        }
        stackView.addArrangedSubview(view)
        let countLabel = UILabel().then {
            $0.text = String(count)
            $0.textAlignment = .center
        }
        view.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
        }
        let infoLabel = UILabel().then {
            $0.text = text
            $0.textAlignment = .center
        }
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(15)
            make.top.equalTo(countLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
        }
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.tag = 101
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.separator.snp.remakeConstraints {[weak self] (make) in
                guard let self = self else { return }
                make.width.equalTo(40)
                make.height.equalTo(4)
                make.bottom.equalTo(self.tabView.snp.bottom).offset(10)
                make.centerX.equalTo(view.snp.centerX)
            }
        }
    }

    @IBAction func toggleGoBack(_ sender: Any) {

    }
}

extension PersonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
//        switch indexPath.row % 2 {
//        case 0:
//            cell.titleLabel.text = "Lorem Ipsum is simply dummy text ."
//            cell.contentView.backgroundColor = UIColor.darkGray
//        default:
//            cell.contentView.backgroundColor = UIColor.black
//            cell.titleLabel.text = "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
//            cell.titleLabel.textColor = .white
//        }
        return UITableViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxHeight = headerView.frame.height - (scrollView.contentOffset.y + headerView.frame.height)
        let height = min(max(maxHeight, 0), 400)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        tabView.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.size.width, height: tabView.frame.height)
        headerView.layoutIfNeeded()
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            print(" you reached end of the table")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let indexPath = IndexPath(row: 0, section: 0)
        //        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
