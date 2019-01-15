//
//  CollectionView.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/10/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Then

extension UICollectionView {
    func showEmptyDataMessage(_ message: String) {
        let size = self.bounds.size
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height)).then {
            $0.text = message
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.sfProDisplayFont(ofSize: 20, weight: .medium)
            $0.sizeToFit()
        }
        self.backgroundView = messageLabel
    }

    func hideEmptyMessage() {
        self.backgroundView = nil
    }
}
