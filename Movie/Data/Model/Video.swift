//
//  Video.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Video: Mappable {
    var id: Int = 0
    var iso6391 = ""
    var iso3166 = ""
    var key = ""
    var name = ""
    var site = ""
    var size: Int = 0
    var type = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        iso6391 <- map["iso_639_1"]
        iso3166 <- map["iso_3166_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        type <- map["type"]
    }
}
