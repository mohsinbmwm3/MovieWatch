//
//  Extensions.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

public extension UIColor {
    struct Custom {
        static let darkOrange = UIColor(r: 255, g: 128, b: 0)
        static let lightOrange = UIColor(r: 255, g: 179, b: 102)
        
        static let darkRed = UIColor(r: 168, g: 0, b: 0)
        static let lightRed = UIColor(r: 240, g: 0, b: 0)
        
        static let darkGreen = UIColor(r: 20, g: 184, b: 20)
        static let lightGreen = UIColor(r: 0, g: 204, b: 0)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/256, green: g/256, blue: b/256, alpha: 1)
    }
}
