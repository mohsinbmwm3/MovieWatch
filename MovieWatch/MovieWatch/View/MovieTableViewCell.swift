//
//  MovieTableViewCell.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieLang: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var imgVwPoster: UIImageLoaderView!
    
    var viewModel: MovieViewModelOutput? {
        didSet {
            if let _vm = viewModel {
                imgVwPoster.loadImageWithUrl(_vm.posterUrl())
                lblMovieTitle.text = _vm.movieDisplayName()
                lblMovieLang.text = _vm.language()
                lblMovieYear.text = _vm.movieReleasedYear()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
