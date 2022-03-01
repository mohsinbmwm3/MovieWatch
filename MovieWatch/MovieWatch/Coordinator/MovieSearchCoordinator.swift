//
//  FirstCoordinator.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation
import UIKit

class MovieSearchCoordinator: Coordinator {
    var viewModel: ViewModel?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController, viewModel: ViewModel?) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    @discardableResult
    func start() -> Bool {
        if let _vc = MovieSearchViewController.instantiate() {
            navigationController.viewControllers = [_vc]
            return true
        }
        return false
    }
}
extension MovieSearchCoordinator: MovieSearchDelegate {
    func navigateToMovieDetails(viewModel: MovieViewModel?) {
        let movieDetailsCoordinator = MovieDetailsCoordnator(navigationController: navigationController, viewModel: viewModel)
        movieDetailsCoordinator.delegate = self
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
    }
}
extension MovieSearchCoordinator: BackToMovieSearchDelegate {
    func navigateBackToMovieSearch(coordinator: MovieDetailsCoordnator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
