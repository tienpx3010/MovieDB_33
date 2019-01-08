//
//  MovieViewController.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/1/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable

final class MovieViewController: UIViewController {
    @IBOutlet private weak var nowMovieCollectionView: UICollectionView!
    @IBOutlet private weak var topMovieCollectionView: UICollectionView!
    
    private struct Constants {
        static let nowCellWidth: CGFloat = 147 * Screen.ratioWidth
        static let nowCellHeight: CGFloat = 270 * Screen.ratioHeight
        static let topCellWidth: CGFloat = 140 * Screen.ratioWidth
        static let topCellHeight: CGFloat = 230 * Screen.ratioHeight
        static let toggleCellAnimationDuration = 0.2
        static let toggleCellScale: CGFloat = 0.5
        static let sectionInsets = UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10
        )
        static let loadingNowMovies = Array(repeating: Movie(), count: 3)
        static let loadingTopMovies = Array(repeating: Movie(), count: 7)
    }
    private var nowMovies = [Movie]() {
        didSet {
            self.nowMovieCollectionView.reloadData()
        }
    }
    private var topMovies = [Movie]() {
        didSet {
            self.topMovieCollectionView.reloadData()
        }
    }
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)

    override func viewDidLoad() {
        super.viewDidLoad()
        configNowMovieCollectionView()
        configtopMovieCollectionView()
        //URLCache.shared.removeAllCachedResponses()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configNowMovieCollectionView() {
        nowMovies = Constants.loadingNowMovies
        nowMovieCollectionView.delegate = self
        nowMovieCollectionView.dataSource = self
        nowMovieCollectionView.register(cellType: NowMovieCollectionViewCell.self)
        nowMovieCollectionView.register(cellType: NowLoadMoreCollectionViewCell.self)
    }
    
    private func configtopMovieCollectionView() {
        topMovies = Constants.loadingTopMovies
        topMovieCollectionView.delegate = self
        topMovieCollectionView.dataSource = self
        topMovieCollectionView.register(cellType: TopMovieCollectionViewCell.self)
        topMovieCollectionView.register(cellType: TopLoadMoreCollectionViewCell.self)
    }
    
    private func fetchData() {
        fetchMovieNowPlaying()
        fetchMoviePopular()
    }
    
    private func fetchMovieNowPlaying() {
        movieRepository.getMovies(type: .now, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let results = movieResponse?.movies else { return }
                self.nowMovies = results
            case .failure(let error):
                print(error as Any)
            }
        }
    }
    
    private func fetchMoviePopular() {
        movieRepository.getMovies(type: .top, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let results = movieResponse?.movies else { return }
                self.topMovies = results
            case .failure(let error):
                print(error as Any)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case nowMovieCollectionView:
            return nowMovies.count + 1
        case topMovieCollectionView:
            return topMovies.count + 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case nowMovieCollectionView:
            if indexPath.row == nowMovies.count {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as NowLoadMoreCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as NowMovieCollectionViewCell
                cell.setContentForCell(movie: nowMovies[indexPath.row])
                return cell
            }
        case topMovieCollectionView:
            if indexPath.row == topMovies.count {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as TopLoadMoreCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as TopMovieCollectionViewCell
                cell.setContentForCell(movie: topMovies[indexPath.row])
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        UIView.animate(withDuration: Constants.toggleCellAnimationDuration) {
            cell.transform = .init(scaleX: Constants.toggleCellScale, y: Constants.toggleCellScale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        UIView.animate(withDuration: Constants.toggleCellAnimationDuration) {
            cell.transform = .identity
        }
        let viewController = MovieDetailViewController.instantiate()
        switch collectionView {
        case nowMovieCollectionView:
            viewController.movie = nowMovies[indexPath.row]
        case topMovieCollectionView:
            viewController.movie = topMovies[indexPath.row]
        default:
            return
        }
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case nowMovieCollectionView:
            return CGSize(width: Constants.nowCellWidth, height: Constants.nowCellHeight)
        case topMovieCollectionView:
            return CGSize(width: Constants.topCellWidth, height: Constants.topCellHeight)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
}

// MARK: - StoryboardSceneBased
extension MovieViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
