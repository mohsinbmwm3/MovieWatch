//
//  ViewController.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

protocol MovieSearchDelegate: AnyObject {
    func navigateToMovieDetails(viewModel: MovieViewModelOutput?) -> Void
}

protocol MovieFetchDelegate: AnyObject {
    func fetchMovies() -> Void
}

class MovieSearchViewController: UITableViewController {
    var searchController = UISearchController(searchResultsController: nil)
    weak var navDelegate: MovieSearchDelegate?
    var viewModel = MovieSearchViewModel(api: LocalJsonMovieSearch())
    
    var searchCategoriesDatasource: SearchTableViewDatasource<MovieSearchCategories, UITableViewCell>?
    var valueToMapDatasource: SearchTableViewDatasource<String, UITableViewCell>?
    var moviesDatasource: SearchTableViewDatasource<MovieViewModelOutput, MovieTableViewCell>?
    
    private var shouldRefreshData = true
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search movies by title/genre/actor/director"
        definesPresentationContext = true
        title = "Movies"
        navigationItem.searchController = searchController
        tableView.rowHeight = UITableView.automaticDimension
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldRefreshData {
            shouldRefreshData = false
            fetchMovies()
        }
    }
}
extension MovieSearchViewController {
    @IBAction func btnHomeClicked(_ sender: UIBarButtonItem) {
        refreshSearchCategoryDatasource()
        updateTableViewDatasource(datasource: searchCategoriesDatasource)
    }
}
extension MovieSearchViewController {
    func fetchMovies() {
        viewModel.fetchMovies { [weak self] result in
            switch result {
            case .success:
                self?.refreshSearchCategoryDatasource()
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
        }
    }
}
extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty ?? true {
            refreshSearchCategoryDatasource()
        } else {
            filterContentForSearchText(searchController.searchBar.text ?? "")
        }
    }
    func filterContentForSearchText(_ searchText: String) {
        refreshMoviesDatasource(movies: viewModel.filter(searchString: searchText))
        updateTableViewDatasource(datasource: moviesDatasource)
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
        }
        updateTableViewDatasource(datasource: searchCategoriesDatasource)
    }
    func refreshMapToValueDatasource() {
        if let _ = valueToMapDatasource {
            valueToMapDatasource?.updateItems(items: viewModel.allKeys())
        } else {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "valueCellId")
            valueToMapDatasource = SearchTableViewDatasource<String, UITableViewCell>(items: viewModel.allKeys(), cellId: "valueCellId", configure: { cell, item, indexPath in
                cell.textLabel?.text = item
            }, selectionHandler: { [weak self] item, indexPath in
                self?.refreshMoviesDatasource(movies: self?.viewModel.allValues(key: item) ?? [])
                self?.updateTableViewDatasource(datasource: self?.moviesDatasource)
            })
        }
        updateTableViewDatasource(datasource: valueToMapDatasource)
    }
    func refreshMoviesDatasource(movies: [MovieViewModelOutput]) {
        if let _ = moviesDatasource {
            moviesDatasource?.updateItems(items: movies)
        } else {
            tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "moviesCellId")
            moviesDatasource = SearchTableViewDatasource<MovieViewModelOutput, MovieTableViewCell>(items: movies, cellId: "moviesCellId", configure: { cell, item, indexPath in
                cell.viewModel = item
            }, selectionHandler: { [weak self] item, indexPath in
                self?.navDelegate?.navigateToMovieDetails(viewModel: item)
            })
        }
    }
}
extension MovieSearchViewController {
    static func instantiate() -> MovieSearchViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieSearchVC") as? MovieSearchViewController ?? nil
    }
}
