//
//  FirstCoordinator.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import Foundation
import UIKit

class MovieSearchCoordinator: Coordinator {
    var data: AnyObject?
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController, data: AnyObject?) {
        self.navigationController = navigationController
        self.data = data
    }
    
    @discardableResult
    func start() -> Bool {
        if let _vc = MovieSearchViewController.instantiate() {
            _vc.navDelegate = self
            navigationController.viewControllers = [_vc]
            return true
        }
        return false
    }
}
extension MovieSearchCoordinator: MovieSearchDelegate {
    func navigateToMovieDetails(viewModel: MovieViewModelOutput?) {
        let movieDetailsCoordinator = MovieDetailsCoordnator(navigationController: navigationController, data: viewModel)
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
