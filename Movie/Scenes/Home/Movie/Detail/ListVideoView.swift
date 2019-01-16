//
//  ListVideoView.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit

final class ListVideoView: UIView {
    private struct Constants {
        static let tableViewCellHeight: CGFloat = 220
    }

    var tableView = UITableView()
    var videos = [Video]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    private func configView() {
        tableView = UITableView(frame: frame).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: VideoTableViewCell.self)
            $0.allowsSelection = true
            $0.isUserInteractionEnabled = true
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension ListVideoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as VideoTableViewCell
        cell.setContentForCell(video: videos[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListVideoView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let parentViewController = parentViewController else {
            return
        }
        let videoPlayer = VideoPlayerViewController()
        videoPlayer.url = videos[indexPath.row].key
        parentViewController.present(videoPlayer, animated: false, completion: nil)
    }
}
