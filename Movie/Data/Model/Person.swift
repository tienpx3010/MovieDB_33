//
//  Person.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/4/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Person: Mappable {
    var birthday = ""
    var knownFor = ""
    var deathday = ""
    var id: Int = 0
    var name = ""
    var alsoKnownAs = [String]()
    var gender: Int = 0
    var biography = ""
    var popularity: Float = 0.0
    var placeOfBirth = ""
    var profilePath = ""
    var adult = false
    var imdbId = ""
    var homepage = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        birthday <- map["birthday"]
        knownFor <- map["known_for_department"]
        deathday <- map["deathday"]
        id <- map["id"]
        name <- map["name"]
        alsoKnownAs <- map["also_known_as"]
        gender <- map["gender"]
        biography <- map["biography"]
        popularity <- map["popularity"]
        placeOfBirth <- map["place_of_birth"]
        profilePath <- map["profile_path"]
        adult <- map["adult"]
        imdbId <- map["imdb_id"]
        homepage <- map["homepage"]
    }
}
