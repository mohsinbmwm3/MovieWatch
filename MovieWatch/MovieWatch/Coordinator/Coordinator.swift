//
//  Coordinator.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation
import UIKit

class ViewModel {}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var data: AnyObject? { get set }
    
    init(navigationController: UINavigationController, data: AnyObject?)
    
    @discardableResult
    func start() -> Bool
}
