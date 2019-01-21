//
//  DatabaseManager.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/16/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import RealmSwift

final class DatabaseManager {
    private var database: Realm?
    static let sharedInstance = DatabaseManager()

    init() {
        do {
            database = try Realm()
        } catch let error as NSError {
            database = nil
            print(error)
        }
    }

    func getData() -> Results<Movie>? {
        guard let database = database else { return nil }
        let results: Results<Movie> = database.objects(Movie.self)
        return results
    }
    
    func checkExist(movieId: Int) -> Bool {
        guard let database = database, let movie = database.object(ofType: Movie.self, forPrimaryKey: movieId) else {
            return false
        }
        return true
    }

    func insert(movie: Movie) {
        guard let database = database else { return }
        do {
            try database.write {
                let object = database.create(Movie.self, value: movie)
                database.add(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }

    func delete(movieId: Int) {
        guard let database = database else { return }
        do {
            try database.write {
                guard let object = database.object(ofType: Movie.self, forPrimaryKey: movieId) else { return }
                database.delete(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
