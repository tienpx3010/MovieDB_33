//
//  MovieListViewController.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/13/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable

final class MovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topBarView: UIView!
    
    var type: MovieType?
    var genreId: Int = 0
    
    private struct Constants {
    }
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)
    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configCollectionView()
        configFetchData()
    }
    
    private func configView() {
        if let type = type {
            fetchDataByCategory(type: type)
            return
        } else {
            fetchDataByGenre(id: genreId)
        }
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: TopMovieCollectionViewCell.self)
    }
    
    private func configFetchData() {
        
    }
    
    private func fetchDataByGenre(id: Int) {
        movieRepository.getMoviesByGenre(id: id, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let results = movieResponse?.movies else { return }
                self.movies = results
            case .failure(let error):
                print(error as Any)
            }
        }
    }
    
    private func fetchDataByCategory(type: MovieType) {
        movieRepository.getMovies(type: type, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let results = movieResponse?.movies else { return }
                self.movies = results
            case .failure(let error):
                print(error as Any)
            }
        }
    }
    
    @IBAction func toggleGoBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TopMovieCollectionViewCell
        cell.setContentForCell(movie: movies[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.animate()
    }
}

// MARK: - StoryboardSceneBased
extension MovieListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movie
}
