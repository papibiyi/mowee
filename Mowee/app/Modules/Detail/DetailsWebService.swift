//
//  DetailsWebService.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

class DetailsWebService {
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie?, Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "\(NetworkConstants.baseURL.rawValue)movie/\(id)", params: [NetworkConstants.apiKeyString.rawValue: NetworkConstants.apiKeyValue.rawValue], completionHandler: completion)
    }
}
