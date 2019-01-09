//
//  Genre.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/7/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Genre: Mappable {
    var id: Int = 0
    var name: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
