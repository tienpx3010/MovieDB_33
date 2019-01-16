//
//  VideoPlayerViewController.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import VGPlayer
import YoutubeDirectLinkExtractor
import SCLAlertView

final class VideoPlayerViewController: UIViewController {
    private struct Constants {
        static let videoErrorMessage = "Video Not Available"
    }
    var player = VGPlayer()
    var url: String?
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
        guard let url = url else {
            dismiss(animated: false, completion: {
                Alert.showError(Constants.videoErrorMessage)
            })
            return
        }
        player.displayView.enterFullscreen()
        DispatchQueue.global().async(execute: {
            DispatchQueue.main.sync {
                VGPlayerCacheManager.shared.cleanAllCache()
            }
        })
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
                            failure: { [weak self] error in
                                guard let self = self else { return }
                                self.player.displayView.exitFullscreen()
                                self.dismiss(animated: false, completion: {
                                    Alert.showError(error.localizedDescription)
                                })})
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigationController = navigationController else { return }
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - VGPlayerViewDelegate
extension VideoPlayerViewController: VGPlayerViewDelegate {
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        player.displayView.exitFullscreen()
        dismiss(animated: false, completion: nil)
    }
}
