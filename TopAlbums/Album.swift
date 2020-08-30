//
//  Album.swift
//  TopAlbums
//
//  Created by Steven Fellows on 8/29/20.
//  Copyright © 2020 Steven Fellows. All rights reserved.
//

import Foundation

struct Album: Codable {
    var name: String?
    var artistName: String?
    var artworkUrl100: URL?
    var url: URL?
    var genres: [Genre]?
    var releaseDate: String?
    var copyright: String?
    
    private var genreNames: String {
        guard let genres = genres else { return "" }
        return (genres.compactMap{ $0.name }).joined(separator: ", ")
    }
    
    private var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = releaseDate, let date = formatter.date(from: releaseDate) else {
            return ""
        }
        formatter.dateFormat = "MMM d, yyyy"

        return formatter.string(from: date)
    }

    var otherInfo: String {
        return "Release Date: \(displayDate)\nGenres: \(genreNames)\nCopyright Info: \(copyright ?? "")"
    }
}

struct Genre: Codable {
    var name: String?
}

struct Response: Codable {
    var feed: Feed?
}

struct Feed: Codable {
    var results: [Album]?
}
