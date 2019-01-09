//
//  Date+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/5/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

extension Date {
    static func fromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
            return Date()
        }
        return date
    }

    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
}
