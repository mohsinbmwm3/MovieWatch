//
//  MovieSearchViewModel.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

enum MovieSearchCategories: String, CaseIterable {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
}

class MovieSearchViewModel: NSObject {
    private let api: MovieSearchApi
    
    private let searchCriteria: [MovieSearchCategories]
    private var movies: [MovieViewModel]
    private var operationalList: [MovieViewModel]
    private var _isSearching = false
    private var searchText = ""
    
    init(api: MovieSearchApi) {
        self.api = api
        searchCriteria = MovieSearchCategories.allCases
        movies = []
        operationalList = []
    }
    func resetSearch() {
        operationalList = movies
    }
    func fetchMovies(completion: @escaping (ResultType<MovieSearchViewModel?, ApiError>) -> Void) {
        api.fetchMovies { [weak self] (result: ResultType<MoviesModel, ApiError>) in
            switch result {
            case .success(let model):
                self?.movies = model.map { MovieViewModel(model: $0) }
                self?.operationalList = self?.movies ?? []
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
extension MovieSearchViewModel {
    func searchBarTextDidBeginEditing() {
        _isSearching = true
    }
    func searchBarTextDidEndEditing() {
        _isSearching = false
    }
    func searchBarTextDidChange(searchText: String) {
        if searchText.isEmpty {
            _isSearching = false
        } else {
            _isSearching = true
        }
        self.searchText = searchText
        cleanUpAndFilter()
    }
    func cleanUpAndFilter() {
        if !_isSearching || searchText.isEmpty {
            resetSearch()
        } else {
            filterArray(searchString: searchText)
        }
    }
    func filterArray(searchString: String) {
        resetSearch()
        operationalList = filter(searchString: searchString)
    }
    func filter(searchString: String) -> [MovieViewModel] {
//        var i: Int = 0
//        for item in operationalList {
//            if item.unitName.range(of: searchString, options: [.caseInsensitive]) != nil {
//                item.show = true
//            }
//            operationalList[i] = item
//            i = i + 1
//        }
        return operationalList
    }
}
