//
//  MovieSearchApi.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation

protocol MovieSearchApi: AnyObject {
    func fetchMovies(completion: @escaping (ResultType<MoviesModel, ApiError>) -> Void) -> Void
}
