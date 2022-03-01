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
    var viewModel = MovieSearchViewModel(api: LocalJsonMovieSearch(service: LocalJSONService(fileName: "movies")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationItem.searchController = searchController
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMovies { result in
            switch result {
            case .success(let viewModel):
                print(viewModel)
            case .failure(let error):
                print(error)
            }
        }
    }
    func action() {
        navDelegate?.navigateToMovieDetails(viewModel: nil)
    }
}
extension MovieSearchViewController {
    func fetchMovies() {
        
    }
}
extension MovieSearchViewController {
    static func instantiate() -> MovieSearchViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieSearchVC") as? MovieSearchViewController ?? nil
    }
}

extension MovieSearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
