//
//  Dictionary+.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/3/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
