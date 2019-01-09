//
//  MovieResponse.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import ObjectMapper

class MoviesResponse: Mappable {
    var movies = [Movie]()

    required init(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        movies <- map["results"]
    }
}
