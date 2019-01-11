//
//  GenreRequest.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/10/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

class GenreRequest: BaseRequest {
    required init() {
        let body: [String: Any] = [
            "language": "en-US"
        ]
        super.init(url: URLs.APIGenreListURL, requestType: .get, body: body)
    }
}
