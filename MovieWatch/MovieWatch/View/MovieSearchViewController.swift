//
//  ViewController.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

protocol MovieSearchDelegate: AnyObject {
    func navigateToMovieDetails(viewModel: MovieViewModel?) -> Void
}

protocol MovieFetchDelegate: AnyObject {
    func fetchMovies() -> Void
}

class MovieSearchViewController: UITableViewController {
    var searchController = UISearchController() {
        didSet {
            searchController.searchBar.placeholder = "search movies by title/genre/actor/director"
        }
    }
    weak var navDelegate: MovieSearchDelegate?
    var viewModel = MovieSearchViewModel(api: LocalJsonMovieSearch())
    
    var searchCategoriesDatasource: SearchTableViewDatasource<MovieSearchCategories, UITableViewCell>?
    var valueToMapDatasource: SearchTableViewDatasource<String, UITableViewCell>?
    var moviesDatasource: SearchTableViewDatasource<MovieViewModel, MovieTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationItem.searchController = searchController
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCellId")
        refreshSearchCategoryDatasource()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMovies()
    }
    func action() {
        navDelegate?.navigateToMovieDetails(viewModel: nil)
    }
}
extension MovieSearchViewController {
    func fetchMovies() {
        viewModel.fetchMovies { [weak self] result in
            switch result {
            case .success:
                print("")
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
        }
    }
}
extension MovieSearchViewController {
    func updateTableViewDatasource(datasource: TableViewDatasource?) {
        tableView.dataSource = datasource
        tableView.delegate = datasource
        tableView.reloadData()
    }
    func refreshSearchCategoryDatasource() {
        if let _ = searchCategoriesDatasource {
        } else {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCatCellId")
            searchCategoriesDatasource = SearchTableViewDatasource<MovieSearchCategories, UITableViewCell>(items: MovieSearchCategories.allCases, cellId: "searchCatCellId", configure: { cell, item, indexPath in
                cell.textLabel?.text = item.rawValue
            }, selectionHandler: { [weak self] item, indexPath in
                self?.viewModel.updateSelected(searchCategory: item)
                self?.refreshMapToValueDatasource()
            })
            updateTableViewDatasource(datasource: searchCategoriesDatasource)
        }
    }
    func refreshMapToValueDatasource() {
        if let _ = valueToMapDatasource {
            valueToMapDatasource?.updateItems(items: viewModel.allKeys())
        } else {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "valueCellId")
            valueToMapDatasource = SearchTableViewDatasource<String, UITableViewCell>(items: viewModel.allKeys(), cellId: "valueCellId", configure: { cell, item, indexPath in
                cell.textLabel?.text = item
            }, selectionHandler: { [weak self] item, indexPath in
                self?.refreshMoviesDatasource(key: item)
                self?.updateTableViewDatasource(datasource: self?.moviesDatasource)
            })
        }
        updateTableViewDatasource(datasource: valueToMapDatasource)
    }
    func refreshMoviesDatasource(key: String) {
        if let _ = moviesDatasource {
            moviesDatasource?.updateItems(items: viewModel.allValues(key: key))
        } else {
            tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCellId")
            moviesDatasource = SearchTableViewDatasource<MovieViewModel, MovieTableViewCell>(items: viewModel.allValues(key: key), cellId: "moviesCellId", configure: { cell, item, indexPath in
                cell.lblMovieName?.text = item.model.title
            }, selectionHandler: { item, indexPath in
                
            })
        }
    }
}
extension MovieSearchViewController {
    static func instantiate() -> MovieSearchViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieSearchVC") as? MovieSearchViewController ?? nil
    }
}
