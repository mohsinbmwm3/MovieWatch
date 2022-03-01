//
//  LocalJsonService.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation

class LocalJSONService: Service {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    func fetchData<T: Codable>(completion: @escaping Completion<T>) {
        if let _path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: _path), options: .dataReadingMapped)
                completion(.success(try JSONDecoder().decode(T.self, from: data)))
            } catch {
                completion(.failure(.parsingError(error: error)))
            }
        } else {
            completion(.failure(.fileNotFound))
        }
    }
}
