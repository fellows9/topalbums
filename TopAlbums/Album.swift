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

    var otherInfo: String {
        var info: String = ""
        if let date = displayDate {
            info += "Release Date: \(date)\n"
        }
        if let genreList = genreNames {
            info += "Genres: \(genreList)\n"
        }
        if let copyrightInfo = copyright {
            info += "\(copyrightInfo)"
        }
        return info
    }
    
    private var displayDate: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = releaseDate, let date = formatter.date(from: releaseDate) else {
            return nil
        }
        formatter.dateFormat = "MMM d, yyyy"

        return formatter.string(from: date)
    }

    private var genreNames: String? {
        guard let genres = genres else { return nil }
        var genresNamesSet = Set(genres.compactMap { $0.name })
        genresNamesSet.remove("Music")
        return genresNamesSet.joined(separator: ", ")
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
