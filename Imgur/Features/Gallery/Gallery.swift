//
//  Gallery.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation

struct GalleryData: Codable {
    var data: [Gallery]?
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([Gallery].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.data, forKey: .data)
    }
}

struct Gallery: Codable {
    var title: String?
    var cover: String?
    var images: [Images]?
    
    enum CodingKeys: CodingKey {
        case title
        case cover
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.cover = try container.decodeIfPresent(String.self, forKey: .cover)
        self.images = try container.decodeIfPresent([Images].self, forKey: .images)
    }
    
    init?(title: String?, cover: String?, images: [Images]?) {
        self.title = title
        self.cover = cover
        self.images = images
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.cover, forKey: .cover)
        try container.encodeIfPresent(self.images, forKey: .images)
    }
}

struct Images: Codable {
    var id: String?
    var link: String?
    
    enum CodingKeys: CodingKey {
        case id
        case link
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
    }
    
    init?(id: String?, link: String?) {
        self.id = id
        self.link = link
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.link, forKey: .link)
    }
}
