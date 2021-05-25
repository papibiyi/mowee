//
//  Movie.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation


struct Movie: Codable, Equatable {
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
    }
}

struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}
