//
//  UIImageView+Additions.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadThumbnail(with url: URL?) {
        guard let url = url else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        WebService.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                break
            }
        }
    }
}
