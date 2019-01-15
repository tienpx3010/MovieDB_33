//
//  CreditCollectionViewCell.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/8/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class CreditCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var jobLabel: UILabel!
    
    func setContentForCell(imageUrl: String, name: String, job: String) {
        imageView.sd_setImage(with: URL(string: URLs.APIImagesPath + imageUrl),
                              completed: { [weak self] (_, error, _, _) in
                                guard let self = self else { return }
                                if error != nil {
                                    self.imageView.image = #imageLiteral(resourceName: "poster_not_available")
                                }
                                self.imageView.hideSkeleton()
        })
        nameLabel.text = name
        jobLabel.text = job
    }
}
