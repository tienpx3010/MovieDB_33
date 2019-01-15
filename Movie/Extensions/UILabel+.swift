//
//  UILabel+.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/28/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        get {
            guard let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern,
                                                                     at: 0,
                                                                     effectiveRange: .none) as? CGFloat else {
                return 0
            }
            return currentLetterSpace
        }
    }
}
