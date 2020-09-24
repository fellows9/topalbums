//
//  WebService.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error?)
}

protocol WebServiceProtocol {
    func fetchAlbums(completion: @escaping (Result<[Album]>) -> Void)
}

class WebService: WebServiceProtocol {
    
    static let baseURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    
    func fetchAlbums(completion: @escaping (Result<[Album]>) -> Void) {
        guard let baseURL = WebService.baseURL else {
            completion(.failure(nil))
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            var urlRequest = URLRequest(url: baseURL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil, let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                do {
                    let albumResponse = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        guard let albums = albumResponse.feed?.results else {
                            completion(.failure(nil))
                            return
                        }
                        completion(.success(albums))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            })
            task.resume()
        }
    }

    public static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async() {
                    guard error == nil, let data = data else {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }

}

class MockWebService: WebServiceProtocol {
    var responseObject: Response?

    func fetchAlbums(completion: @escaping (Result<[Album]>) -> Void) {
        guard let albums = responseObject?.feed?.results else {
            completion(.failure(nil))
            return
        }
        completion(.success(albums))
    }
}

