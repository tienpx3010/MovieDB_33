//
//  MovieType.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

enum MovieType {
    case now, upcoming, popular, top

    var url: String {
        switch self {
        case .now:
            return URLs.APIMovieNowPlayingURL
        case .upcoming:
            return URLs.APIMovieUpcomingURL
        case .popular:
            return URLs.APIMoviePopularURL
        case .top:
            return URLs.APIMovieTopRatedURL
        }
    }
}
