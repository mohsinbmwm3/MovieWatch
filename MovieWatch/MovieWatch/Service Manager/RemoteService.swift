//
//  RemoteService.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation

class RemoteService: Service {
    var endPoint: String
    
    init(endPoint: String) {
        self.endPoint = endPoint
    }
    func fetchData<T>(completion: @escaping Completion<T>) where T : Decodable, T : Encodable {
        
    }
}
