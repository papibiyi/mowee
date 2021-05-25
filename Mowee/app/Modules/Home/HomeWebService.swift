//
//  HomeWebService.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation

class HomeWebService {
    func getPopularMovies(completion: @escaping (Result<NowPlayingResponse, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "https://api.themoviedb.org/3/movie/popular?api_key=144a73d4f608ecf606e7214c24cbd49b", params: nil, completionHandler: completion)
    }
    
    func getNowPlaying(completion: @escaping (Result<NowPlayingResponse, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "https://api.themoviedb.org/3/movie/now_playing?api_key=144a73d4f608ecf606e7214c24cbd49b", params: nil, completionHandler: completion)
    }
}
