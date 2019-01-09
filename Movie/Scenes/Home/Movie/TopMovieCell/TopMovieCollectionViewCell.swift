//
//  TopMovieCollectionViewCell.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/4/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import SkeletonView

final class TopMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var animationScore: UIView!
    @IBOutlet private weak var shadowView: UIImageView!

    private struct Constants {
        static let imageCornerRadius: CGFloat = 5
    }

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
        titleLabel.text = movie.title
        let releaseDate = Date.fromString(date: movie.releaseDate)
        yearLabel.text = releaseDate.year
        setMovieScore(movie.voteAverage)
        shadowView.isHidden = false
        hideAnimation()
    }

    private func configCell() {
        imageView.setCornerRadius(Constants.imageCornerRadius)
        shadowView.isHidden = true
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = scoreLabel.frame.height / 2
        scoreLabel.backgroundColor = UIColor.secondGradientColor
        showAnimation()
    }

    private func showAnimation() {
        [imageView, yearLabel, animationScore, titleLabel].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }

    private func setMovieScore(_ score: Float) {
        scoreLabel.attributedText = String.createScoreStyleAttributedString(score, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }

    private func hideAnimation() {
        animationScore.hideSkeleton()
        titleLabel.hideSkeleton()
        yearLabel.hideSkeleton()
    }
}
