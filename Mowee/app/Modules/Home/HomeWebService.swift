//
//  HomeWebService.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation

class HomeWebService {
    func getPopularMovies(completion: @escaping (Result<NowPlayingResponse, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "\(NetworkConstants.baseURL.rawValue)/movie/popular", params: [NetworkConstants.apiKeyString.rawValue: NetworkConstants.apiKeyValue.rawValue], completionHandler: completion)
    }
    
    func getNowPlaying(completion: @escaping (Result<NowPlayingResponse, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "\(NetworkConstants.baseURL.rawValue)/movie/now_playing", params: [NetworkConstants.apiKeyString.rawValue: NetworkConstants.apiKeyValue.rawValue], completionHandler: completion)
    }
}
