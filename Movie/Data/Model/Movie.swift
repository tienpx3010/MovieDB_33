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
    // Detail
    var imdbId = ""
    var budget: Int = 0
    var genres = [Genre]()
    var revenue: Int = 0
    var runtime: Int = 0
    var status = ""
    var tagline = ""
    var cast = [Cast]()
    var crew = [Crew]()
    // Video
    var videos = [Video]()
    // Info
    var info: String {
        let year = Date.fromString(date: releaseDate).year
        let duration = Util.minutesToHoursMinutes(minutes: runtime)
        return "(\(year)) - \(duration)"
    }
    var genresString: String {
        let string = genres.map { String($0.name) }
        return string.joined(separator: ", ")
    }
    
    init?(map: Map) {
    }
    
    init() {
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
        // Detail
        imdbId <- map["imdb_id"]
        budget <- map["budget"]
        genres <- map["genres"]
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        status <- map["status"]
        tagline <- map["tagline"]
        cast <- map["credits.cast"]
        crew <- map["credits.crew"]
        videos <- map["videos.results"]
    }
}
