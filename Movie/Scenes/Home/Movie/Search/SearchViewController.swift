//
//  SearchViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/9/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit
import Then
import Reusable
import Alamofire
import UILoadControl

final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var autoCompleteTableView: UITableView!
    @IBOutlet weak var seeAllResultsButton: UIButton!
    @IBOutlet weak var genreCollectionView: UICollectionView!

    private struct Constants {
        static let minimumInputToSearch = 3
        static let minimumInputErrorMessage = "Minimum 3 characters"
        static let emptyDataMessage = "No result found"
        static let unusedCategory = "TV Movie"
        static let seeAllResultsText = "See results for "
        static let limitAutoCompleteResult: Int = 5
        static let movieCellWidth: CGFloat = 160
        static let movieCellHeight: CGFloat = 256
        static let genreCellHeight: CGFloat = 40
    }
    private let movieRepository = MovieRepositoryImpl(api: APIService.share)
    private var page: Int = 0
    private var totalPage: Int = 0
    private var movies = [Movie]() {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    private var autoCompleteMovies = [Movie]() {
        didSet {
            autoCompleteTableView.reloadData()
        }
    }
    private var genres = [Genre]() {
        didSet {
            genreCollectionView.reloadData()
        }
    }
    private var selectedGenres = [Genre]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configTableView()
        configView()
        configGenreCollectionView()
        fetchGenreList()
    }
    
    private func configTableView() {
        autoCompleteTableView.do {
            $0.dataSource = self
            $0.isHidden = true
        }
    }
    
    private func configView() {
        topBarView.backgroundColor = UIColor.gradientColorForView(view: topBarView)
        searchBar.tintColor = .white
        activityIndicator.stopAnimating()
    }

    private func configGenreCollectionView() {
        genreCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: GenreCollectionViewCell.self)
        }
    }

    private func setSeeAllResultsButton() {
        let mutableAttributedString = String.createTwoStyleAttributedString(firstText: Constants.seeAllResultsText,
                                                                            secondText: searchBar.text ?? "")
        seeAllResultsButton.setAttributedTitle(mutableAttributedString, for: .normal)
    }
    
    private func configCollectionView() {
        movieCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: TopMovieCollectionViewCell.self)
            $0.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
            $0.loadControl?.heightLimit = 60
        }
        searchBar.do {
            $0.becomeFirstResponder()
            $0.backgroundImage = UIImage()
            $0.throttlingInterval = 2
            $0.customDelegate = self
        }
    }
    
    private func searchMovie(text: String, page: Int, completion: (() -> Void)? = nil) {
        movieRepository.searchMovie(text: text, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let response = movieResponse else { return }
                let results = response.movies
                self.page = response.page
                self.totalPage = response.totalPage
                if results.isEmpty {
                    self.movieCollectionView.showEmptyDataMessage(Constants.emptyDataMessage)
                } else {
                    var outputMovies = [Movie]()
                    if self.selectedGenres.isEmpty {
                        outputMovies = results
                    } else {
                        for movie in results {
                            let resultGenres = movie.genreIds
                            let movieSetGenres = Set(resultGenres.map({ $0 }))
                            let searchGenres = Set(self.selectedGenres.map({ $0.id }))
                            let isMatch = searchGenres.isSubset(of: movieSetGenres)
                            if isMatch {
                                outputMovies.append(movie)
                            }
                        }
                    }
                    if page == 1 {
                        self.movies = outputMovies
                    } else {
                        self.movies += outputMovies
                    }
                }
                completion?()
            case .failure(let error):
                print(error as Any)
            }
        }
    }
    
    private func searchAutoCompleteMovie(text: String) {
        movieRepository.searchMovie(text: text, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                guard let results = movieResponse?.movies else { return }
                print("Success Auto")
                if results.count > Constants.limitAutoCompleteResult {
                    self.autoCompleteMovies = Array(results[0...Constants.limitAutoCompleteResult])
                }
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error as Any)
            }
        }
    }

    private func fetchGenreList() {
        movieRepository.getGenreList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genreResponse):
                guard let results = genreResponse?.genres else { return }
                self.genres = results.filter { $0.name != Constants.unusedCategory }
            case .failure(let error):
                print(error as Any)
            }
        }
    }

    private func fetchMoreData() {
        guard let text = searchBar.text, let loadControl = movieCollectionView.loadControl else { return }
        let nextPage = page + 1
        if nextPage != totalPage {
            searchMovie(text: text, page: nextPage) {
                loadControl.endLoading()
            }
        } else {
            loadControl.endLoading()
        }
    }

    @IBAction private func toggleSearchAllResults(_ sender: Any) {
        guard let text = searchBar.text else { return }
        customSearchBarSearchButtonClicked(searchText: text)
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case movieCollectionView:
            return movies.count
        case genreCollectionView:
            return genres.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case movieCollectionView:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as TopMovieCollectionViewCell
            cell.setContentForCell(movie: movies[indexPath.row])
            return cell
        case genreCollectionView:
            let cell = genreCollectionView.dequeueReusableCell(for: indexPath) as GenreCollectionViewCell
            cell.setContentForCell(title: genres[indexPath.row].name)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case movieCollectionView:
            let detailViewController = MovieDetailViewController.instantiate()
            detailViewController.movie = movies[indexPath.row]
            present(detailViewController, animated: true, completion: nil)
        case genreCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell else {
                return
            }
            cell.animate()
            if cell.isToggle {
                cell.titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                selectedGenres = selectedGenres.filter { $0.id != genres[indexPath.row].id }
            } else {
                cell.titleLabel.backgroundColor = UIColor.black
                selectedGenres.append(genres[indexPath.row])
            }
            cell.isToggle = !cell.isToggle
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case movieCollectionView:
            return CGSize(width: Constants.movieCellWidth, height: Constants.movieCellHeight)
        case genreCollectionView:
            let label = UILabel(frame: CGRect.zero)
            label.text = genres[indexPath.row].name
            label.sizeToFit()
            return CGSize(width: label.frame.width + 10, height: Constants.genreCellHeight)
        default:
            return CGSize.zero
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = autoCompleteMovies[indexPath.row].title
        cell.detailTextLabel?.text = Date.fromString(date: autoCompleteMovies[indexPath.row].releaseDate).year
        return cell
    }
}

// MARK: - CustomSearchBarDelegate
extension SearchViewController: CustomSearchBarDelegate {
    func customSearchBarCancelButtonClicked() {
        dismiss(animated: false, completion: nil)
    }
    
    func customSearchBar(textDidChange searchText: String) {
        if searchText.count > Constants.minimumInputToSearch {
            searchAutoCompleteMovie(text: searchText)
        }
    }
    
    func customSearchBarSearchButtonClicked(searchText: String) {
        searchBar.resignFirstResponder()
        if searchText.count > Constants.minimumInputToSearch {
            activityIndicator.startAnimating()
            autoCompleteTableView.isHidden = true
            movies = []
            searchMovie(text: searchText, page: 1) {
                self.activityIndicator.stopAnimating()
            }
        } else {
            Alert.showError(Constants.minimumInputErrorMessage)
        }
    }
    
    func customSearchBar(textWillChange searchText: String) {
        print("Text: " + searchText)
        if searchText.count > Constants.minimumInputToSearch {
            movieCollectionView.hideEmptyMessage()
            autoCompleteTableView.isHidden = false
            autoCompleteMovies = []
            movies = []
            setSeeAllResultsButton()
            activityIndicator.startAnimating()
        }
    }
}

// MARK: - UIScrollViewDelegate
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let loadControl = scrollView.loadControl else { return }
        loadControl.update()
    }

    @objc func loadMore(sender: AnyObject?) {
        fetchMoreData()
    }
}

// MARK: - StoryboardSceneBased
extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
