//
//  Movie.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    var voteCount: Int = 0
    var id: Int = 0
    var video = false
    var voteAverage: Float = 0.0
    var title = ""
    var popularity: Float = 0.0
    var posterPath = ""
    var originalLanguage = ""
    var originalTitle = ""
    var genreIds = [Int]()
    var backdropPath = ""
    var adult = false
    var overview = ""
    var releaseDate = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        voteCount <- map["vote_count"]
        id <- map["id"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        genreIds <- map["genre_ids"]
        backdropPath <- map["backdrop_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
    }
}
