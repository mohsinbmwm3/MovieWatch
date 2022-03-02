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
    func filter(searchString: String) -> [MovieViewModel]
}

protocol MovieViewModelInput {
    init(model: MoviesModelElement)
}

protocol MovieViewModelOutput: AnyObject {
    func movieDisplayName() -> String
    func directorsDisplayString() -> String
    func movieReleasedYear() -> String
    func actors() -> String
    func genre() -> String
    func language() -> String
    func posterUrl() -> URL?
    func plot() -> String
    func ratings() -> [Rating]
    func castAndCrew() -> String
    func multiplier(forRatingModel: Rating) -> Double
}
