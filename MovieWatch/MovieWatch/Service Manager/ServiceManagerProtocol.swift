//
//  ServiceManagerProtocol.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation

enum ResultType<Value, Error> {
    case success(Value)
    case failure(Error)
}

typealias Completion<T: Codable> = (ResultType<T, ApiError>) -> Void

enum ApiError: Error {
    case invalidURL
    case fileNotFound
    case dataEmpty
    case generic(error: Error)
    case parsingError(error: Error)
}

protocol Service: AnyObject {
    func fetchData<T: Codable>(completion: @escaping Completion<T>) -> Void
}
