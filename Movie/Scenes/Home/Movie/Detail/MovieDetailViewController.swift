//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/3/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import Cosmos

class MovieDetailViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = Storyboards.movie
    @IBOutlet private weak var backImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var scoreView: CosmosView!
    @IBOutlet private weak var creditCollectionView: UICollectionView!

    var movie: Movie!
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configCollectionView()
        fetchData()
    }

    private func fetchData() {
        movieRepository.getMovieDetail(id: movie.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let result = movieResponse else { return }
                self.movie = result
                self.updateContentForCell()
            case .failure(let error):
                print(error as Any)
            }
        }
    }

    private func configView() {
        backImage.sd_setImage(with: URL(string: URLs.APIImagesPath + movie.backdropPath),
                              completed: { [weak self] (_, _, _, _) in
                                guard let self = self else { return }
                                self.backImage.hideSkeleton()
        })
        posterImage.sd_setImage(with: URL(string: URLs.APIImagesPath + movie.posterPath),
                              completed: { [weak self] (_, _, _, _) in
                                guard let self = self else { return }
                                self.posterImage.hideSkeleton()
        })
        titleLabel.text = movie.title
        contentTextView.text = movie.overview
        scoreLabel.attributedText = String.createScoreStyleAttributedString(movie.voteAverage, color: #colorLiteral(red: 0.8392156863, green: 0.09411764706, blue: 0.1647058824, alpha: 1))
        scoreView.rating = Double(movie.voteAverage / 2)
    }

    private func configCollectionView() {
        creditCollectionView.dataSource = self
        creditCollectionView.register(cellType: CreditCollectionViewCell.self)
    }

    private func updateContentForCell() {
        infoLabel.text = "\(movie.getInfoString())"
        genreLabel.text = "\(movie.getGenresString())"
        creditCollectionView.reloadData()
    }

    private func showAnimation() {
        posterImage.showAnimatedGradientSkeleton()
        backImage.showAnimatedGradientSkeleton()
        infoLabel.showAnimatedGradientSkeleton()
        genreLabel.showAnimatedGradientSkeleton()
    }

    private func hideAnimation() {
        infoLabel.hideSkeleton()
        genreLabel.hideSkeleton()
    }

    @IBAction private func toggleGoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.cast.count + movie.crew.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CreditCollectionViewCell
        print(indexPath.row)
        print(movie.cast.count)
        if indexPath.row > movie.cast.count - 1 {
            // Crew
            let crew = movie.crew[indexPath.row - movie.cast.count]
            cell.setContentForCell(imageUrl: crew.profilePath, name: crew.name, job: crew.department)
        } else {
            // Cast
            let cast = movie.cast[indexPath.row]
            cell.setContentForCell(imageUrl: cast.profilePath, name: cast.name, job: cast.character)
        }
        return cell
    }
}
