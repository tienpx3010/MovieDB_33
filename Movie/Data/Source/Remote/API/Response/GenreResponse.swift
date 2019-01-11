//
//  GenreResponse.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/10/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import ObjectMapper

class GenreResponse: Mappable {
    var genres = [Genre]()

    required init(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        genres <- map["genres"]
    }
}
