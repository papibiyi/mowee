//
//  MoviePersisterManager.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

class MoviePersisterManager {
    
   static let shared = MoviePersisterManager()
    
    private init () {}
    
    private static var documentsFolder: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private static var fileURL: URL? {
        return documentsFolder?.appendingPathComponent("favouriteMovie.data")
    }
    
    func load() -> [Movie]? {
        guard let url = MoviePersisterManager.fileURL else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let favourite = try? JSONDecoder().decode(Favourites.self, from: data) else { return nil }
        return favourite.movies
    }
    
    func save(movie: Movie) {
            var movies = self.load() ?? []
            guard !movies.contains(where: { (data) -> Bool in
                data.id == movie.id
            }) else {return}
            movies.append(movie)
            guard let data = try? JSONEncoder().encode(Favourites(movies: movies)) else { fatalError("Error encoding data") }
            guard let url = MoviePersisterManager.fileURL else { return }
            try? data.write(to: url)
    }
    
    func remove(movie: Movie) {
        var movies = self.load() ?? []
        guard let index = movies.firstIndex(where: { $0.id == movie.id}) else {return}
        movies.remove(at: index)
        guard let data = try? JSONEncoder().encode(Favourites(movies: movies)) else { fatalError("Error encoding data") }
        guard let url = MoviePersisterManager.fileURL else { return }
        try? data.write(to: url)
    }
}
