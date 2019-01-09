//
//  Cast.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/6/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Cast: Mappable {
    var castId: Int = 0
    var character = ""
    var creditId = ""
    var gender: Int = 0
    var id: Int = 0
    var name = ""
    var order: Int = 0
    var profilePath = ""

	init?(map: Map) {
	}

    init(){
    }

	mutating func mapping(map: Map) {
        castId <- map["cast_id"]
        character <- map["character"]
        creditId <- map["credit_id"]
        gender <- map["gender"]
        id <- map["id"]
        name <- map["name"]
        order <- map["order"]
        profilePath <- map["profile_path"]
	}
}
