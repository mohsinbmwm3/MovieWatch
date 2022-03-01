//
//  MovieSearchRepository.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation

protocol MovieSearchRepositoryDelegate: AnyObject {
    var api: MovieSearchApi { get set }
    func fetchMovies() -> Void 
}

class MovieSearchRepository: MovieSearchRepositoryDelegate {
    var api: MovieSearchApi
    
    init(api: MovieSearchApi) {
        self.api = api
    }
    
    func fetchMovies() {
        
    }
}
