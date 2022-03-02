//
//  MovieViewModel.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

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
    func rating() -> [Rating]
    
//    title, plot, cast & crew, released date, genre and rating
}

class MovieViewModel: ViewModel, MovieViewModelInput, MovieViewModelOutput {
    let model: MoviesModelElement
    
    required init(model: MoviesModelElement) {
        self.model = model
    }
    
    func movieDisplayName() -> String {
        return model.title ?? "-"
    }
    func directorsDisplayString() -> String {
        return "Directed by: " + (model.director ?? "-")
    }
    func movieReleasedYear() -> String {
        return "Released: " + (model.released ?? "-")
    }
    func actors() -> String {
        return "Cast: " + (model.actors ?? "-")
    }
    func genre() -> String {
        return "Genre: " + (model.genre ?? "-")
    }
    func language() -> String {
        return "Language: " + (model.language ?? "-")
    }
    func plot() -> String {
        return "Plot: " + (model.plot ?? "-")
    }
    func rating() -> [Rating] {
        return model.ratings ?? []
    }
    
    func posterUrl() -> URL? {
        return URL(string: model.poster ?? "")
    }
}
