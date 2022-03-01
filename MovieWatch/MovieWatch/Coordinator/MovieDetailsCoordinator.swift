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
    weak var viewModel: ViewModel?
    
    required init(navigationController: UINavigationController, viewModel: ViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    @discardableResult
    func start() -> Bool {
        guard let _vm = viewModel as? MovieViewModel else { return false }
        if let _vc = MovieDetailsViewController.instantiate(viewModel: _vm) {
            navigationController.viewControllers = [_vc]
            return true
        }
        return false
    }
}

