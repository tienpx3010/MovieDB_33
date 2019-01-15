//
//  MovieByGenreRequest.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/13/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

final class MovieByGenreRequest: BaseRequest {
    required init(genreId: Int, page: Int) {
        let body: [String: Any]  = [
            "page": page,
            "with_genres": genreId
        ]
        super.init(url: URLs.APIDiscoverMovieURL, requestType: .get, body: body)
    }
}

