//
//  MovieRepository.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

protocol MovieRepository {
    func getMovies(type: MovieType, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void)
    func getMovieDetail(id: Int, completion: @escaping (BaseResult<Movie>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
    private var api: APIService!

    required init(api: APIService) {
        self.api = api
    }

    func getMovies(type: MovieType, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void) {
        guard let api = api else { return }
        let input = MovieRequest(type: type, page: page)
        api.request(input: input) { (object: MoviesResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }

    func getMovieDetail(id: Int, completion: @escaping (BaseResult<Movie>) -> Void) {
        guard let api = api else { return }
        let input = MovieDetailRequest(id: id)
        api.request(input: input) { (object: Movie?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
}
