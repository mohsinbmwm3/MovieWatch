//
//  MovieDetailsCoordinator.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

protocol BackToMovieSearchDelegate: AnyObject {
    func navigateBackToMovieSearch(coordinator: MovieDetailsCoordnator) -> Void
}

class MovieDetailsCoordnator: Coordinator {    
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMovieSearchDelegate?
    var data: AnyObject?
    
    required init(navigationController: UINavigationController, data: AnyObject?) {
        self.navigationController = navigationController
        self.data = data
    }
    
    @discardableResult
    func start() -> Bool {
        guard let _vm = data as? MovieViewModelOutput else { return false }
        if let _vc = MovieDetailsViewController.instantiate(viewModel: _vm) {
            navigationController.pushViewController(_vc, animated: true)
            return true
        }
        return false
    }
}

