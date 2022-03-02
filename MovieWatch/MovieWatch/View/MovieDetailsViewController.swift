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

    @IBOutlet weak var imgVwPoster: UIImageLoaderView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblActor: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    
    weak var navDelegate: MovieDetailsDelegate?
    var viewModel: MovieViewModelOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgVwPoster.loadImageWithUrl(viewModel?.posterUrl())
        lblMovieName.text = viewModel?.movieDisplayName() ?? "-"
        lblDirector.text = viewModel?.directorsDisplayString() ?? "-"
        lblActor.text = viewModel?.actors() ?? "-"
        lblYear.text = viewModel?.movieReleasedYear() ?? "-"
        lblGenre.text = viewModel?.genre() ?? "-"
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        navDelegate?.navigateBackToMovieSearch()
    }
}
extension MovieDetailsViewController {
    static func instantiate(viewModel: MovieViewModelOutput) -> MovieDetailsViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetailsVC") as? MovieDetailsViewController ?? nil
        vc?.viewModel = viewModel
        
        return vc
    }
}
