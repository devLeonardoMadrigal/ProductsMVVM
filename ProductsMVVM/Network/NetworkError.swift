//
//  NetworkError.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case noData
    case invalidResponse
    case invalidResponseCode
    case parsingError
}

extension NetworkError: LocalizedError{
    var errorDescription: String?{
        switch self {
        case .invalidURL:
            return "URL provided is not valid"
        case .noData:
            return "Server returned no data"
        case .invalidResponse:
            return "Invalid response from the server"
        case .invalidResponseCode:
            return "Invalid response code from the server"
        case .parsingError:
            return "Unable to parse data"
        }
    }
}
