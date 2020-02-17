//
//  CustomImageView.swift
//  Itunes Search
//
//  Created by Didi on 17.02.20.
//  Copyright © 2020 Didi. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    let images = NSCache<AnyObject, AnyObject>()
    
    func loadImage(urlString: String) {
        imageUrlString = urlString
        if imageUrlString == "" { return }
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        image = nil
        if let imageFromCache = images.object(forKey: urlString as AnyObject) {
            self.image = imageFromCache as? UIImage
            return
        }
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                return
            }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    self.images.setObject(imageToCache!, forKey: urlString as AnyObject)

                }
            }.resume()
        }
    
}
