//
//  ImageLoader.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 02/03/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class UIImageLoaderView: UIImageView {

    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL?) {
        guard let _url = url else { return }

        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        if let imageFromCache = imageCache.object(forKey: NSString(string: _url.absoluteString)) {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
        }

        URLSession.shared.dataTask(with: _url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: NSString(string: _url.absoluteString))
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
