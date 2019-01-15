//
//  VideoTableViewCell.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class VideoTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var thumbnailImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    private func configCell() {
        selectionStyle = .none
    }
    
    func setContentForCell(video: Video) {
        thumbnailImage.sd_setImage(with: URL(string: String(format: URLs.YoutubeThumbnailImage, video.key)),
                              completed: { [weak self] (_, error, _, _) in
                                guard let self = self else { return }
                                if error != nil {
                                    self.thumbnailImage.image = #imageLiteral(resourceName: "poster_not_available")
                                }
        })
        titleLabel.text = video.name
        typeLabel.text = video.type
    }
}
