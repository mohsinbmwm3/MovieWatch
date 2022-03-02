//
//  Model.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation

// MARK: - MoviesModelElement
class MoviesModelElement: Codable {
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type: String?
    let dvd: String?
    let boxOffice, production: String?
    let website: String?
    let response: String?
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }

    init(title: String?, year: String?, rated: String?, released: String?, runtime: String?, genre: String?, director: String?, writer: String?, actors: String?, plot: String?, language: String?, country: String?, awards: String?, poster: String?, ratings: [Rating]?, metascore: String?, imdbRating: String?, imdbVotes: String?, imdbID: String?, type: String?, dvd: String?, boxOffice: String?, production: String?, website: String?, response: String?, totalSeasons: String?) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.ratings = ratings
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.dvd = dvd
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.response = response
        self.totalSeasons = totalSeasons
    }
}
extension MoviesModelElement {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MoviesModelElement.self, from: data)
        self.init(title: me.title, year: me.year, rated: me.rated, released: me.released, runtime: me.runtime, genre: me.genre, director: me.director, writer: me.writer, actors: me.actors, plot: me.plot, language: me.language, country: me.country, awards: me.awards, poster: me.poster, ratings: me.ratings, metascore: me.metascore, imdbRating: me.imdbRating, imdbVotes: me.imdbVotes, imdbID: me.imdbID, type: me.type, dvd: me.dvd, boxOffice: me.boxOffice, production: me.production, website: me.website, response: me.response, totalSeasons: me.totalSeasons)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

class Rating: Codable {
    let source: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }

    init(source: String?, value: String?) {
        self.source = source
        self.value = value
    }
}
extension Rating {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Rating.self, from: data)
        self.init(source: me.source, value: me.value)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

typealias MoviesModel = [MoviesModelElement]

extension Array where Element == MoviesModel.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MoviesModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
