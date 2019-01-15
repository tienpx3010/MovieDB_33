//
//  MovieResponse.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import ObjectMapper

class MoviesResponse: Mappable {
    var page: Int = 0
    var totalPage: Int = 0
    var totalResult: Int = 0
    var movies = [Movie]()

    required init(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        page <- map["page"]
        totalPage <- map["total_pages"]
        totalResult <- map["total_results"]
        movies <- map["results"]
    }
}
