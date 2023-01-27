//
//  EndPoint.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.imgur.com/3"
    }
}
