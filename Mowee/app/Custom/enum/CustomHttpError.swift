//
//  CustomHttpError.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import Foundation

enum CustomHttpError: Error {
    case notJson
    case badRequest
    case serverError
    case unknown(error: String)
}

extension CustomHttpError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notJson:
            return "Response not in JSON format"
        case .badRequest:
            return "BadRequest"
        case .serverError:
            return "ServerError"
        case .unknown(let error):
            return error
        }
    }
}
