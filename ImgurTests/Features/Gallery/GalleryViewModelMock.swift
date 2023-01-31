//
//  GalleryViewModelMock.swift
//  ImgurTests
//
//  Created by Daniel Griso Filho on 31/01/23.
//

import Foundation
import Combine
@testable import Imgur

class GalleryViewModelMock {
    
    var cancellables = Set<AnyCancellable>()
    private let valueSbject = CurrentValueSubject<GalleryObject?, Never>(nil)
    private let erroMessage = CurrentValueSubject<String, Never>("")
    
    var valuePublisher: AnyPublisher<GalleryObject?, Never> {
        valueSbject.map { value in
            value
        }.eraseToAnyPublisher()
    }
    
    func fetchAPI() {
        let imageMock = [Images(id: "D4eIMgp",
                               link: "https://i.imgur.com/D4eIMgp.jpg")!]
        
        let galleryMock = Gallery(title:
                                    "No lieutenant, your men are already dead",
                                  cover: "D4eIMgp", images: imageMock)
        
        let galleryObjectMock = GalleryObject(gallery: galleryMock!)
        
        valueSbject.send(galleryObjectMock)
    }
    
}
