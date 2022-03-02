//
//  MovieTableViewCell.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDirector: UILabel!
    @IBOutlet weak var imgVwPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
