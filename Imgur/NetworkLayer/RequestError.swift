//
//  RequestError.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case data
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "Server is not responding, please try again"
        case .unauthorized:
            return "Session expired"
        case .data:
            return "Unable to look at data"
        default:
            return "Unknown error"
        }
    }
}
