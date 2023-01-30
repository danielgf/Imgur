//
//  Service.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation
import Combine

protocol Service {
    func performAPIRequest<T: Codable>(urlSession: URLSession, endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, Error>
}

extension Service {
    func performAPIRequest<T: Codable>(urlSession: URLSession, endpoint: Endpoint,  responseModel: T.Type) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params
         
        guard let urlRequest = urlComponents.url else {
            return Fail(error: RequestError
                .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization
                .data(withJSONObject: body, options: [])
        }
        
        return urlSession.dataTaskPublisher(for: request)
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
            .decode(type: responseModel, decoder: JSONDecoder())
            .catch { error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
