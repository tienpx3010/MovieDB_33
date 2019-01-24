//
//  FavoriteViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/16/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Reusable
import EmptyDataSet_Swift
import Then
import SnapKit
import SCLAlertView

final class FavoriteViewController: BaseViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    private struct Constants {
        static let emptyFavoriteMessage = "No favorite movie found."
        static let detailMessage = "Movies you like will appear here."
    }
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)
    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private let databaseManager = DatabaseManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func configView() {
        collectionView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: Constants.emptyFavoriteMessage,
                                                     attributes: [.font: UIFont.sfProDisplayFont(ofSize: 16, weight: .bold),
                                                                  .foregroundColor: UIColor.black]))
                .detailLabelString(NSAttributedString(string: Constants.detailMessage))
                .image(#imageLiteral(resourceName: "icon_cinema"))
                .dataSetBackgroundColor(.white)
                .verticalSpace(20)
                .shouldDisplay(true)
        }
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: TopMovieCollectionViewCell.self)
        }
    }
    
    private func fetchData() {
        guard let data = DatabaseManager.sharedInstance.getData() else { return }
        movies = Array(data)
    }
    
    @IBAction func toggleGoBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TopMovieCollectionViewCell
        // Add More Button
        let moreButton = UIButton().then {
            $0.setTitle("", for: .normal)
            $0.setImage(#imageLiteral(resourceName: "icon_more"), for: .normal)
            $0.tag = movies[indexPath.row].id
            $0.addTarget(self, action: #selector(toggleMoreAction), for: .touchUpInside)
        }
        cell.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-28)
            make.right.equalToSuperview().offset(-5)
        }
        cell.setContentForCell(movie: movies[indexPath.row])
        return cell
    }
    
    @objc func toggleMoreAction(sender: UIButton!) {
        sender.animate()
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            showCircularIcon: false,
            hideWhenBackgroundViewIsTapped: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Delete from playlist",
                            backgroundColor: .red,
                            textColor: .white,
                            showTimeout: nil) { [weak self] in
                                guard let self = self else { return }
                                self.databaseManager.delete(movieId: sender.tag) { [weak self] result in
                                    guard let self = self else { return }
                                    switch result {
                                    case .success:
                                        self.fetchData()
                                    case .failure(let error):
                                        print(error as Any)
                                    }
                                }
        }
        alertView.addButton("Share", action: {})
        alertView.showSuccess("", subTitle: "")
    }
}

// MARK: - UICollectionViewDelegatez
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.animate()
        let viewController = MovieDetailViewController.instantiate()
        viewController.movie = movies[indexPath.row]
        present(viewController, animated: true, completion: nil)
    }
}
