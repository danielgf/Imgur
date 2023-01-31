//
//  GalleryEndpoint.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import UIKit

enum GalleryEndpoint: Endpoint {
    
    case animals(animal: String, page: Int)
    
    var path: String {
        return "/3/gallery/search"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var params: [URLQueryItem]? {
        switch self {
        case .animals(let animal, let page):
            return [
                URLQueryItem(name: "q", value: animal),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var headers: [String: String]? {
        return [
            "Authorization": clientID
        ]
    }
    
    var body: [String: Any]? {
        return nil
    }
    
}
