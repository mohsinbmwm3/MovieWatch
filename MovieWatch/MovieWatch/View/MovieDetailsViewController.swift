//
//  MovieDetailsViewController.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

protocol MovieDetailsDelegate: AnyObject {
    func navigateBackToMovieSearch() -> Void
}

class MovieDetailsViewController: UIViewController {

    weak var navDelegate: MovieDetailsDelegate?
    weak var viewModel: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        navDelegate?.navigateBackToMovieSearch()
    }
}
extension MovieDetailsViewController {
    static func instantiate(viewModel: MovieViewModel) -> MovieDetailsViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController ?? nil
        vc?.viewModel = viewModel
        
        return vc
    }
}
