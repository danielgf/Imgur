//
//  GalleryViewModel.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation

protocol GalleryViewModelProtocol {
    func fetchGallery(page: Int)
}

/// I used final for this class to prevent someone to inherit and change anything
final class GalleryViewModel: GalleryViewModelProtocol {
    
    func fetchGallery(page: Int) {
        print(page)
    }
}
