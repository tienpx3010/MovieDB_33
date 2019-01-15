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
    func searchMovie(text: String, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void)
    func getGenreList(completion: @escaping (BaseResult<GenreResponse>) -> Void)
    func getMoviesByGenre(id: Int, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void)
}

final class MovieRepositoryImpl: MovieRepository {
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

    func searchMovie(text: String, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void) {
        guard let api = api else { return }
        let input = SearchRequest(text: text, page: page)
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

    func getGenreList(completion: @escaping (BaseResult<GenreResponse>) -> Void) {
        guard let api = api else { return }
        let input = GenreRequest()
        api.request(input: input) { (object: GenreResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    return completion(.failure(error: nil))
                }
                return completion(.failure(error: error))
            }
            completion(.success(object))
        }
    }
    
    func getMoviesByGenre(id: Int, page: Int, completion: @escaping (BaseResult<MoviesResponse>) -> Void) {
        guard let api = api else { return }
        let input = MovieByGenreRequest(genreId: id, page: page)
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
}
