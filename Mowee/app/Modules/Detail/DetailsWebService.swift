//
//  DetailsWebService.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

class DetailsWebService {
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie?, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "https://api.themoviedb.org/3/movie/\(id)?api_key=144a73d4f608ecf606e7214c24cbd49b", params: nil, completionHandler: completion)
    }
}
