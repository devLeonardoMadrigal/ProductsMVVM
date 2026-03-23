//
//  NetworkManager.swift
//  ProductsMVVM
//
//  Created by Leonardo Madrigal on 3/23/26.
//

import Foundation
import Combine

protocol Networking{
    func fetchDataFromAPI<T:Decodable>(urlString: String, modelType:T.Type) -> AnyPublisher<T, Error>
}

final class NetworkManager{
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: Networking{

    func fetchDataFromAPI<T>(urlString: String, modelType: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return self.urlSession.dataTaskPublisher(for: url)
            .tryMap { (data,urlResponse) in
                guard let response = urlResponse as? HTTPURLResponse else{
                    throw NetworkError.invalidResponse
                }
                guard(200...299).contains(response.statusCode)else{
                    throw NetworkError.invalidResponseCode
                }
                return data
            }
            .decode(type: modelType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


