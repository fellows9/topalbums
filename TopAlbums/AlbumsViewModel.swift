//
//  AlbumsViewModel.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import Foundation

class AlbumsViewModel {
    let webService: WebService = .init()
    var dataSource: [Album] = .init()
    
    func loadDataSource(completion: @escaping (Result<Bool>) -> Void) {
        webService.fetchAlbums { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.dataSource = albums
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
