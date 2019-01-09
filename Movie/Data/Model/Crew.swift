//
//  Crew.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/6/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Crew: Mappable {
    var creditId = ""
    var department = ""
    var gender: Int = 0
    var id: Int = 0
    var job = ""
    var name = ""
    var profilePath = ""
    
    init?(map: Map) {
    }
    
    init(){
    }
    
    mutating func mapping(map: Map) {
        creditId <- map["credit_id"]
        department <- map["department"]
        gender <- map["gender"]
        id <- map["id"]
        job <- map["job"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
