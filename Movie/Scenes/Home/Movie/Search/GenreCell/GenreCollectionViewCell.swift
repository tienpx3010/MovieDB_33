//
//  GenreCollectionViewCell.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/14/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable

final class GenreCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var titleLabel: UILabel!
    var isToggle = false
    private struct Constants {
        static let labelCornerRadius: CGFloat = 5
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }

    private func configCell() {
        titleLabel.setCornerRadius(Constants.labelCornerRadius)
        titleLabel.backgroundColor = UIColor.lightGray
    }

    func setContentForCell(title: String) {
        titleLabel.text = title
    }
}
