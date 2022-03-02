//
//  Protocols.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation

protocol MovieSearchViewModelInput {
    init(api: MovieSearchApi)
    func fetchMovies(completion: @escaping (ResultType<MovieSearchViewModel?, ApiError>) -> Void) -> Void
}
protocol MovieSearchViewModelOutput {
    func numberOfSearchCriteria() -> Int
    func allCategories() -> [MovieSearchCategories]
    func searchCriteria(atIndex: Int) -> MovieSearchCategories
    
    func mapForSelectedSearchCategory() -> [String: [MovieViewModel]]
    
    func allKeys() -> [String]
    func numberOfKeys() -> Int
    func key(atIndex: Int) -> String
    
    func values(forKey: String) -> [MovieViewModel]?
    func allValues(key: String) -> [MovieViewModel]
    func value(atIndex: Int, forKey: String) -> MovieViewModel?
}
protocol MovieSearchViewModelFilterActions {
    func searchBarTextDidBeginEditing() -> Void
    func searchBarTextDidEndEditing() -> Void
    func searchBarTextDidChange(searchText: String) -> Void
    func clearFilter()  -> Void
    func filter(searchString: String) -> [MovieViewModel]
}
