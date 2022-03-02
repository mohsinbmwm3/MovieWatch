//
//  MovieSearchViewModel.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

//enum MovieSearchCategories {
//    case years([String: [MovieViewModel]]?)
//    case genres([String: [MovieViewModel]]?)
//    case directors([String: [MovieViewModel]]?)
//    case actors([String: [MovieViewModel]]?)
//}
enum MovieSearchCategories: String, CaseIterable {
    case years = "Years"
    case genres = "Genres"
    case directors = "Directors"
    case actors = "Actors"
}

class MovieSearchViewModel: NSObject {
    private let api: MovieSearchApi
    
    private var searchCriteria = MovieSearchCategories.allCases
    private var movies: [MovieViewModel]
    private var operationalList: [MovieViewModel]
    private var _isSearching = false
    private var searchText = ""
    
    private var yearToMovieMap = [String: [MovieViewModel]]()
    private var genreToMovieMap = [String: [MovieViewModel]]()
    private var directorToMovieMap = [String: [MovieViewModel]]()
    private var actorToMovieMap = [String: [MovieViewModel]]()
    
    private var selectedSearchCategory: MovieSearchCategories = .years
    private var _keysForSelectedSearchCategory = [String]()
    
    init(api: MovieSearchApi) {
        self.api = api
        movies = []
        operationalList = []
    }
    func resetSearch() {
        operationalList = movies
    }
    func fetchMovies(completion: @escaping (ResultType<MovieSearchViewModel?, ApiError>) -> Void) {
        api.fetchMovies { [weak self] (result: ResultType<MoviesModel, ApiError>) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.movies = model.map { MovieViewModel(model: $0) }
                self.operationalList = self.movies
                for movieVM in self.operationalList {
                    if let _ = self.yearToMovieMap[movieVM.model.year ?? "0"] {
                        self.yearToMovieMap[movieVM.model.year ?? "0"]?.append(movieVM)
                    } else {
                        self.yearToMovieMap[movieVM.model.year ?? "0"] = [movieVM]
                    }
                    for genre in movieVM.model.genre?.components(separatedBy: ", ") ?? [] {
                        if let _ = self.genreToMovieMap[genre] {
                            self.genreToMovieMap[genre]?.append(movieVM)
                        } else {
                            self.genreToMovieMap[genre] = [movieVM]
                        }
                    }
                    for director in movieVM.model.director?.components(separatedBy: ", ") ?? [] {
                        if let _ = self.directorToMovieMap[director] {
                            self.directorToMovieMap[director]?.append(movieVM)
                        } else {
                            self.directorToMovieMap[director] = [movieVM]
                        }
                    }
                    for _actor in movieVM.model.actors?.components(separatedBy: ", ") ?? [] {
                        if let _ = self.actorToMovieMap[_actor] {
                            self.actorToMovieMap[_actor]?.append(movieVM)
                        } else {
                            self.actorToMovieMap[_actor] = [movieVM]
                        }
                    }
                }
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
        return operationalList
    }
}
extension MovieSearchViewModel {
    func numberOfSearchCriteria() -> Int {
        return searchCriteria.count
    }
    func allCategories() -> [MovieSearchCategories] {
        return searchCriteria
    }
    func searchCriteria(atIndex: Int) -> MovieSearchCategories {
        return allCategories()[atIndex]
    }
    func updateSelected(searchCategory: MovieSearchCategories) {
        self.selectedSearchCategory = searchCategory
        _keysForSelectedSearchCategory.removeAll()
        switch selectedSearchCategory {
        case .years:
            _keysForSelectedSearchCategory = Array(yearToMovieMap.keys)
        case .genres:
            _keysForSelectedSearchCategory = Array(genreToMovieMap.keys)
        case .directors:
            _keysForSelectedSearchCategory = Array(directorToMovieMap.keys)
        case .actors:
            _keysForSelectedSearchCategory = Array(actorToMovieMap.keys)
        }
    }
}
extension MovieSearchViewModel {
    func mapForSelectedSearchCategory() -> [String: [MovieViewModel]] {
        switch selectedSearchCategory {
        case .years:
            return yearToMovieMap
        case .genres:
            return genreToMovieMap
        case .directors:
            return directorToMovieMap
        case .actors:
            return actorToMovieMap
        }
    }
    func allKeys() -> [String] {
        return _keysForSelectedSearchCategory
    }
    func numberOfKeys() -> Int {
        return _keysForSelectedSearchCategory.count
    }
    func key(atIndex: Int) -> String {
        return _keysForSelectedSearchCategory[atIndex]
    }
    func values(forKey: String) -> [MovieViewModel]? {
        if let _arr = mapForSelectedSearchCategory()[forKey] {
            return _arr
        }
        return nil
    }
    func allValues(key: String) -> [MovieViewModel] {
        return mapForSelectedSearchCategory()[key] ?? []
    }
    func value(atIndex: Int, forKey: String) -> MovieViewModel? {
        if let _values = values(forKey: forKey) {
            return _values[atIndex]
        }
        return nil
    }
}
