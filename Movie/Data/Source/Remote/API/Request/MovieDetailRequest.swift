//
//  MovieDetailRequest.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/7/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

class MovieDetailRequest: BaseRequest {
    required init(id: Int) {
        let body: [String: Any]  = [
            "language": "en-US",
            "append_to_response": "credits, reviews"
        ]
        let url = URLs.APIMovieDetailURL + "\(id)"
        super.init(url: url, requestType: .get, body: body)
    }
}
