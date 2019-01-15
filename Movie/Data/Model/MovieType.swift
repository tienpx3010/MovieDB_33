//
//  MovieType.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation

enum MovieType: CaseIterable {
    case now, upcoming, popular, top
    var name: String {
        switch self {
        case .now:
            return "Now playing"
        case .upcoming:
            return "Up coming"
        case .popular:
            return "Popular"
        case .top:
            return "Top Rated"
        }
    }
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
