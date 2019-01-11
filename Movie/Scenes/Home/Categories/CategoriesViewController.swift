//
//  CategoriesViewController.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/10/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController {
    @IBOutlet private weak var topBarView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    private let movieRepository = MovieRepositoryImpl(api: APIService.share)
    private struct Constants {
        static let numberOfCategory = MovieType.allCases.count
        static let unusedCategory = "TV Movie"
        static let toggleCellAnimationDuration = 0.2
        static let toggleCellScale: CGFloat = 0.8
    }
    private var genres = [Genre]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configView()
    }

    private func configView() {
        topBarView.backgroundColor = UIColor.gradientColorForView(view: topBarView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: CategoryTableViewCell.self)
    }

    private func fetchData() {
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
}

// MARK: - UITableViewDataSource
extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count + Constants.numberOfCategory - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0...Constants.numberOfCategory - 1:
            cell.setContentForCell(name: MovieType.allCases[indexPath.row].name)
            return cell
        default:
            cell.setContentForCell(name: genres[indexPath.row - Constants.numberOfCategory].name)
            return cell
        }
    }
}

// MARK: - UITableViewDataSource
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else {
            return
        }
        UIView.animate(withDuration: Constants.toggleCellAnimationDuration, animations: { [weak cell] in
            guard let cell = cell else { return }
            cell.transform = .init(scaleX: Constants.toggleCellScale, y: Constants.toggleCellScale)
            }, completion: { [weak cell] _ in
                guard let cell = cell else { return }
                UIView.animate(withDuration: Constants.toggleCellAnimationDuration) {
                    cell.transform = .identity
                }
        })
    }
}
