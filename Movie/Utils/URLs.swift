//
//  URLs.swift
//  Movie
//
//  Created by pham.xuan.tien on 12/28/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

struct URLs {
    private static let APIBaseUrl = "https://api.themoviedb.org/3"

    static let APIImagesOriginalPath = "https://image.tmdb.org/t/p/original"

    static let APIImagesPath = "https://image.tmdb.org/t/p/w300"

    static let APIMovieNowPlayingURL = APIBaseUrl + "/movie/now_playing"

    static let APIMovieUpcomingURL = APIBaseUrl + "/movie/upcoming"

    static let APIMoviePopularURL = APIBaseUrl + "/movie/popular"

    static let APIMovieTopRatedURL = APIBaseUrl + "/movie/top_rated"
}
