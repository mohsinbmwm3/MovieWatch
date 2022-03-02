//
//  LocalJsonMovieSearch.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation

class LocalJsonMovieSearch: MovieSearchApi {
    private let service: Service
    
    init(service: Service = LocalJSONService(fileName: "movies")) {
        self.service = service
    }
    
    func fetchMovies(completion: @escaping (ResultType<MoviesModel, ApiError>) -> Void) {
        service.fetchData { (result: ResultType<MoviesModel, ApiError>) in
            completion(result)
        }
    }
}
