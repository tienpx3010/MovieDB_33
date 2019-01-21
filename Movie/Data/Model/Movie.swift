//
//  Movie.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Movie: Object, Mappable {
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var video = false
    @objc dynamic var voteAverage: Float = 0.0
    @objc dynamic var title = ""
    @objc dynamic var popularity: Float = 0.0
    @objc dynamic var posterPath = ""
    @objc dynamic var originalLanguage = ""
    @objc dynamic var originalTitle = ""
    var genreIds = [Int]()
    @objc dynamic var backdropPath = ""
    @objc dynamic var adult = false
    @objc dynamic var overview = ""
    @objc dynamic var releaseDate = ""
    // Detail
    @objc dynamic var imdbId = ""
    @objc dynamic var budget: Int = 0
    var genres = [Genre]()
    @objc dynamic var revenue: Int = 0
    @objc dynamic var runtime: Int = 0
    @objc dynamic var status = ""
    @objc dynamic var tagline = ""
    var cast = [Cast]()
    var crew = [Crew]()
    // Video
    var videos = [Video]()
    // Job
    var character = ""
    var job = ""
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
    var year: String {
        let year = Date.fromString(date: releaseDate).year
        return year
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
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
        // Info
        character <- map["character"]
        job <- map["job"]
    }
}
