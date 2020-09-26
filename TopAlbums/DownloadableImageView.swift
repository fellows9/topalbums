//
//  DownloadableImageView.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadableImageView: UIImageView {
    var currentTask: URLSessionDataTask?
    
    func loadThumbnail(with url: URL?) {
        guard let url = url else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data, let imageToCache = UIImage(data: data) else { return }
                DispatchQueue.main.async() {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    self?.image = UIImage(data: data)
                }
            }
            self?.currentTask?.resume()
        }
    }
    
    func cancelLoadThumbnail() {
        currentTask?.cancel()
    }
}
