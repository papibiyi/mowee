//
//  HomeViewModel.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation

class HomeViewModel {
    let homeWebService = HomeWebService()
    
    func getNowPlaying(completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        homeWebService.getNowPlaying { (result) in
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
        homeWebService.getPopularMovies { (result) in
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
