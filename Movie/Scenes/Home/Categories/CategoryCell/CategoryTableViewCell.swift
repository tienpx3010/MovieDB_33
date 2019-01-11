//
//  CategoryTableViewCell.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/10/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable

final class CategoryTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private struct Constants {
        static let imageCornerRadius: CGFloat = 5
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        categoryImageView.setCornerRadius(Constants.imageCornerRadius)
        categoryImageView.backgroundColor = UIColor.gradientColorForView(view: categoryImageView)
    }

    func setContentForCell(name: String) {
        nameLabel.text = name
        categoryImageView.image = UIImage(named: name.lowercased())
    }
}
