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
    @IBOutlet weak var titleLabel: UILabel!

    private struct Constants {
        static let labelCornerRadius: CGFloat = 5
    }
    var isToggle = false

    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }

    private func configCell() {
        titleLabel.setCornerRadius(Constants.labelCornerRadius)
        titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    func setContentForCell(title: String) {
        titleLabel.text = title
    }
}
