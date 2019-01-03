//
//  MovieRequest.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/28/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

class MovieRequest: BaseRequest {
    required init(type: MovieType, page: Int) {
        let body: [String: Any]  = [
            "page": page
        ]
        super.init(url: type.url, requestType: .get, body: body)
    }
}
