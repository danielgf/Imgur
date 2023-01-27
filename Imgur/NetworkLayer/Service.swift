//
//  Service.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation
import Combine

protocol Service {
    func performAPIRequest<T: Codable>(urlSession: URLSession, endpoint: Endpoint) -> AnyPublisher<T, Error>
}

extension Service {
    func performAPIRequest<T: Codable>(urlSession: URLSession, endpoint: Endpoint) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.header
         
        guard let urlRequest = urlComponents.url else {
            return Fail(error: RequestError
                .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization
                .data(withJSONObject: body, options: [])
        }
        
        guard let url = request.url else {
            return Fail(error: RequestError
                .invalidURL).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse
                else { throw RequestError.noResponse }
                switch response.statusCode {
                case 200...299:
                    return result.data
                case 401:
                    throw RequestError.unauthorized
                default:
                    throw RequestError.unexpectedStatusCode
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
