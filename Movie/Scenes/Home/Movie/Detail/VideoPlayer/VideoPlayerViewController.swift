//
//  VideoPlayerViewController.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import VGPlayer
import SnapKit
import YoutubeDirectLinkExtractor
import SCLAlertView

class VideoPlayerViewController: UIViewController {
    var player = VGPlayer()
    var url: String!
    var trailerTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(player.displayView)
        player.do {
            $0.backgroundMode = .proceed
            $0.displayView.delegate = self
            $0.displayView.titleLabel.text = trailerTitle
            $0.displayView.timeSlider.minimumTrackTintColor = UIColor.secondGradientColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().async(execute: {
            DispatchQueue.main.sync {
                VGPlayerCacheManager.shared.cleanAllCache()
            }
        })
        player.displayView.enterFullscreen()
        let youtube = YoutubeDirectLinkExtractor()
        youtube.extractInfo(for: .id(url),
                            success: { [weak self] info in
                                guard let videoUrl = info.highestQualityPlayableLink,
                                    let self = self,
                                    let url = URL(string: videoUrl) else {
                                        return
                                }
                                DispatchQueue.main.sync {
                                    self.player.replaceVideo(url)
                                    self.player.play()
                                }},
                            failure: { error in
                                self.player.displayView.exitFullscreen()
                                self.dismiss(animated: false, completion: {
                                    Alert.showError(error.localizedDescription)
                                })})
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension VideoPlayerViewController: VGPlayerViewDelegate {
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        player.displayView.exitFullscreen()
        dismiss(animated: false, completion: nil)
    }
}
