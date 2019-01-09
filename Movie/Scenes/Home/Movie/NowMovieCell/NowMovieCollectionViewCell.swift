//
//  NowMovieCollectionViewCell.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/2/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage
import SkeletonView

final class NowMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var animationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    func setContentForCell(movie: Movie) {
        guard movie.id != 0 else { return }
        imageView.sd_setImage(with: URL(string: URLs.APIImagesPath + movie.posterPath),
                              completed: { [weak self] (_, _, _, _) in
                                guard let self = self else { return }
                                self.imageView.hideSkeleton()
        })
        movieNameLabel.text = movie.title
        hideAnimation()
    }
    
    private func configCell() {
        imageView.setCornerRadius(5)
        imageView.showAnimatedGradientSkeleton()
        animationLabel.showAnimatedGradientSkeleton()
    }
    
    private func hideAnimation() {
        animationLabel.hideSkeleton()
    }
}
