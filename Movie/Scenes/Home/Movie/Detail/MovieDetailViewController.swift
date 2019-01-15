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
import ReadMoreTextView
import SCLAlertView

final class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var backImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var contentTextView: ReadMoreTextView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var scoreView: CosmosView!
    @IBOutlet private weak var creditCollectionView: UICollectionView!
    @IBOutlet private weak var contentHeight: NSLayoutConstraint!
    @IBOutlet private weak var tableContentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var playButton: UIButton!
    
    var movie = Movie()
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configCollectionView()
        configContentTextView()
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
        isMotionEnabled = true
        motionTransitionType = .autoReverse(presenting: .zoomSlide(direction: .left))
        playButton.isHidden = true
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
        creditCollectionView.do {
            $0.dataSource = self
            $0.register(cellType: CreditCollectionViewCell.self)
        }
    }
    
    private func configContentTextView() {
        let mediumFont = UIFont.sfProDisplayFont(ofSize: 16, weight: .medium)
        let mutableAttributedString = NSMutableAttributedString()
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        ]
        let threeDotAttributedString = NSAttributedString(string: String("..."), attributes: firstAttributes)
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        ]
        let readMoreAttributedString = NSAttributedString(string: String(" Read more"), attributes: secondAttributes)
        mutableAttributedString.append(threeDotAttributedString)
        mutableAttributedString.append(readMoreAttributedString)
        let readLessAttributedString = NSAttributedString(string: String(" Read less"), attributes: secondAttributes)
        contentTextView.do {
            $0.shouldTrim = true
            $0.maximumNumberOfLines = 4
            $0.attributedReadMoreText = mutableAttributedString
            $0.attributedReadLessText = readLessAttributedString
            $0.onSizeChange = { [weak self] _ in
                guard let self = self else { return }
                let contentSize = self.contentTextView.sizeThatFits(self.contentTextView.bounds.size)
                self.contentHeight.constant = contentSize.height
                var rect = self.tableContentView.frame
                rect.size.height += 400
                self.tableContentView.frame = rect
                print(self.tableContentView.frame)
                self.tableView.reloadData()
            }
        }
    }
    
    private func updateContentForCell() {
        infoLabel.text = "\(movie.info)"
        genreLabel.text = "\(movie.genresString)"
        playButton.isHidden = false
        creditCollectionView.reloadData()
    }
    
    private func showAnimation() {
        [genreLabel, backImage, infoLabel, genreLabel].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimation() {
        [infoLabel, genreLabel].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func showListVideo() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true,
            hideWhenBackgroundViewIsTapped: true,
            dynamicAnimatorActive: true,
            disableTapGesture: true,
            buttonsLayout: .vertical
        )
        let alert = SCLAlertView(appearance: appearance)
        let subview = ListVideoView(frame: CGRect(x: 0, y: 0, width: 220, height: 400))
        subview.videos = movie.videos
        alert.customSubview = subview
        let icon = #imageLiteral(resourceName: "icon_page_control_selected")
        let color = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0, alpha: 1)
        alert.showCustom(
            "",
            subTitle: "",
            color: color,
            icon: icon,
            closeButtonTitle: "Close",
            timeout: nil,
            colorStyle: 0,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
    }
    
    @IBAction private func toggleGoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func togglePlayVideo(_ sender: Any) {
        showListVideo()
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.cast.count + movie.crew.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CreditCollectionViewCell
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

// MARK: - StoryboardSceneBased
extension MovieDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.movie
}
