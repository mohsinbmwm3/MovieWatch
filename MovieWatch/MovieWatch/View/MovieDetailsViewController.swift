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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCastAndCrew: UILabel!
    @IBOutlet weak var lblReleased: UILabel!
    @IBOutlet weak var lblPlot: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var vwRatingBar: RatingView!
    
    weak var navDelegate: MovieDetailsDelegate?
    var viewModel: MovieViewModelOutput?
    var ratingActionSheet = UIAlertController(title: "Ratings", message: "Select rating source", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRatingActionSheet()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgVwPoster.loadImageWithUrl(viewModel?.posterUrl())
        lblTitle.text = viewModel?.movieDisplayName() ?? "-"
        lblCastAndCrew.text = viewModel?.castAndCrew() ?? "-"
        lblReleased.text = viewModel?.movieReleasedYear() ?? "-"
        lblGenre.text = viewModel?.genre() ?? "-"
        lblPlot.text = viewModel?.plot() ?? "-"
        
        updateRating(rating: viewModel?.ratings().first)
    }
    func createRatingActionSheet() {
        for rating in viewModel?.ratings() ?? [] {
            ratingActionSheet.addAction(UIAlertAction(title: rating.source, style: .default) { [weak self] action in
                self?.updateRating(rating: rating)
            })
        }
        ratingActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
    func updateRating(rating: Rating?) {
        guard let _rating = rating else { return }
        vwRatingBar.value = viewModel?.multiplier(forRatingModel: _rating) ?? 0.0
        btnRating.setTitle((_rating.source ?? "") + " - " + (_rating.value ?? ""), for: .normal)
    }
    @IBAction func btnRatingSourceClicked(_ sender: UIButton) {
        present(ratingActionSheet, animated: true, completion: nil)
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
