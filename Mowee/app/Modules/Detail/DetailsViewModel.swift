//
//  DetailsViewModel.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

class DetailsViewModel {
    let webService = DetailsWebService()
    
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie?, Error>) -> Void) {
        webService.getMovieDetail(id: id, completion: completion)
    }
}
