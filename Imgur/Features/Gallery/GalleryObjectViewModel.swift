//
//  GalleryObjectViewModel.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation

struct GalleryObjectViewModel {
    
    var galleryObject: [GalleryObject]
    
    init(galleryData: GalleryData? = nil) {
        galleryObject = galleryData?.data?.map({ GalleryObject(gallery: $0) }) ?? []
    }
    
}

struct GalleryObject {
    
    var title: String
    var cover: String
    var imageLink: String
    
    init(gallery: Gallery) {
        title = gallery.title ?? ""
        cover = gallery.cover ?? ""
        imageLink = gallery.images?.first(
            where: { $0.id == gallery.cover })?
            .link ?? ""
    }
    
}
