//
//  HomeViewModel.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation

class HomeViewModel {
    let webService = HomeWebService()
    
    func getNowPlaying(completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        webService.getNowPlaying { (result) in
            switch result {
            case .success(let response):
                guard let movies = response.results else {
                    completion(.success(nil))
                    return
                }
                completion(.success(movies))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        webService.getPopularMovies { (result) in
            switch result {
            case .success(let response):
                guard let movies = response.results else {
                    completion(.success(nil))
                    return
                }
                completion(.success(movies))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
