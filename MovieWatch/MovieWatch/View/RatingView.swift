//
//  RatingView.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 03/03/22.
//

import Foundation
import UIKit

class RatingView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblRatingDescription: UILabel!
    @IBOutlet weak var cnstrntWidthOfBarView: NSLayoutConstraint!
    @IBOutlet weak var vwBackingView: UIView! {
        didSet {
            vwBackingView.backgroundColor = UIColor(red: 240/256, green: 240/256, blue: 240/256, alpha: 1.0)
            vwBackingView.layer.cornerRadius = vwBackingView.bounds.height / 2.5
        }
    }
    @IBOutlet weak var vwBar: UIView! {
        didSet {
            vwBar.layer.cornerRadius = vwBar.bounds.height / 2.5
        }
    }
    
    var widthConstraint: NSLayoutConstraint?
    
    var value: Double = 0.0 {
        didSet {
            if value < 0.4 {
                vwBar.backgroundColor = UIColor.Custom.darkRed
                lblRatingDescription.textColor = UIColor.Custom.lightRed
                lblRatingDescription.text = "Below Average Movie"
            } else if value > 0.4 && value < 0.7 {
                vwBar.backgroundColor = UIColor.Custom.darkOrange
                lblRatingDescription.textColor = UIColor.Custom.lightOrange
                lblRatingDescription.text = "Average Movie"
            } else {
                vwBar.backgroundColor = UIColor.Custom.darkGreen
                lblRatingDescription.textColor = UIColor.Custom.lightGreen
                lblRatingDescription.text = "Good Movie"
            }
            widthConstraint?.isActive = false
            widthConstraint = vwBar.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: value)
            widthConstraint?.isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
