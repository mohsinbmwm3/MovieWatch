//
//  RemoteMovieSearchApi.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation

class RemoteMovieSearchApi: MovieSearchApi {
    private let service: Service
    
    init(service: Service = RemoteService(endPoint: "movies/list")) {
        self.service = service
    }
    
    func fetchMovies(completion: (ResultType<MoviesModel, ApiError>) -> Void) {
        
    }
}
