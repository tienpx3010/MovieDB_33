//
//  String+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/8/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func createScoreStyleAttributedString(_ score: Float, color: UIColor) -> NSMutableAttributedString {
        let mediumFont = UIFont.sfProDisplayFont(ofSize: 20, weight: .medium)
        let regularFont = UIFont.sfProDisplayFont(ofSize: 12, weight: .regular)
        let scroreString = String(score)
        let number = scroreString.split(separator: ".")[0]
        let remain = scroreString.split(separator: ".")[1]
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: color
        ]
        let numberAttributedString = NSAttributedString(string: String(number), attributes: firstAttributes)
        let mutableAttributedString = NSMutableAttributedString(attributedString: numberAttributedString)
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .baselineOffset: 5,
            .font: regularFont,
            .foregroundColor: color
        ]
        let remainAttributedString = NSAttributedString(string: String("." + remain), attributes: secondAttributes)
        mutableAttributedString.append(remainAttributedString)
        return mutableAttributedString
    }

    static func createTwoStyleAttributedString(firstText: String, secondText: String) -> NSMutableAttributedString {
        let mediumFont = UIFont.sfProDisplayFont(ofSize: 20, weight: .medium)
        let regularFont = UIFont.sfProDisplayFont(ofSize: 18, weight: .regular)
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: regularFont,
            .foregroundColor: UIColor.black
        ]
        let seeAllAttributedString = NSAttributedString(string: firstText, attributes: firstAttributes)
        let mutableAttributedString = NSMutableAttributedString(attributedString: seeAllAttributedString)
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: UIColor.firstGradientColor
        ]
        let remainAttributedString = NSAttributedString(string: secondText, attributes: secondAttributes)
        mutableAttributedString.append(remainAttributedString)
        return mutableAttributedString
    }

}
