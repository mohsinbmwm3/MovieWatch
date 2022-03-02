//
//  MovieViewModel.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

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
    func ratings() -> [Rating] {
        return model.ratings ?? []
    }
    func castAndCrew() -> String {
        return "Plot: " + (model.actors ?? "-")
    }
    func multiplier(forRatingModel: Rating) -> Double {
        guard let _value = forRatingModel.value else { return 0.0 }
        if _value.contains("%") {
            let index = _value.index(_value.startIndex, offsetBy: _value.count - 1)
            let newVal = String(_value[..<index])
            if let _douleValue = Double(newVal) {
                return _douleValue / 100
            }
        } else if _value.contains("/100") {
            let index = _value.index(_value.endIndex, offsetBy: -4)
            let newVal = String(_value[..<index])
            if let _douleValue = Double(newVal) {
                return _douleValue / 100
            }
        } else if _value.contains("/10") {
            let index = _value.index(_value.endIndex, offsetBy: -3)
            let newVal = String(_value[..<index])
            if let _douleValue = Double(newVal) {
                return (_douleValue * 10) / 100
            }
        }
        return 0.0
    }
    
    func posterUrl() -> URL? {
        return URL(string: model.poster ?? "")
    }
}
