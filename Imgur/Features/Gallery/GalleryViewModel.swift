//
//  GalleryViewModel.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import Foundation
import Combine

/// I used final for this class to prevent someone to inherit and change anything
final class GalleryViewModel: Service, ObservableObject {
    
    // MARK: - Variables and Properties
    var cancellables = Set<AnyCancellable>()
    private var urlSession = URLSession.shared
    @Published var objectViewModel: GalleryObjectViewModel = GalleryObjectViewModel()
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    weak var coordinator: GalleryCoordinator?
    
    // MARK: - Functions
    
    /// Function responsible to call the ViewModel Resques function
    /// - Parameter page: Most receive the page that you want to request
    func fetchGallery(page: Int) {
        
        let endpoint = GalleryEndpoint.animals(animal: "cats", page: page)
        isLoading.toggle()
        performAPIRequest(urlSession: urlSession, endpoint: endpoint, responseModel: GalleryData.self)
            .handleEvents()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading.toggle()
                case .finished:
                    return
                }
            } receiveValue: { [weak self] gallery in
                let newObjects = GalleryObjectViewModel(galleryData: gallery)
                self?.objectViewModel.galleryObject.append(contentsOf: newObjects.galleryObject)
                self?.isLoading.toggle()
            }
            .store(in: &cancellables)
    }
    
    func showDetails(image object: GalleryObject) {
        coordinator?.showDetailViewController(image: object)
    }
}
