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
    var viewModel: ViewModel? { get set }
    
    init(navigationController: UINavigationController, viewModel: ViewModel?)
    
    @discardableResult
    func start() -> Bool
}
