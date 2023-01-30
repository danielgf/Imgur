//
//  GalleryCollectionViewController.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 27/01/23.
//

import UIKit
import Combine

class GalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Variables and Properties
    var viewModel: GalleryViewModel
    var subscriptions = Set<AnyCancellable>()
    private var page: Int = 1
    
    // MARK: - Life cycle
    init(viewModel: GalleryViewModel = GalleryViewModel(),
         collectionViewLayout layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
        title = "Gallery"
        performAPIRequest(page: page)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        registerCells()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    // MARK: - Internal Functions
    
    /// Function responsible to register our custom cell
    private func registerCells() {
        collectionView.register(GalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryCollectionViewCell
            .identifier)
    }
    
    /// Function responsible to call the ViewModel Resques function
    /// - Parameter page: Most pass the page that you want to request
    private func performAPIRequest(page: Int) {
        viewModel.fetchGallery(page: page)
    }
    
    /// Function responsible to bind the ViewModel information to our view so if something change the view is updated automatic
    private func bindViewModel() {
        viewModel.$isLoading.sink { loading in
            // TODO: - Implement the loading screen
            print(loading)
        }.store(in: &subscriptions)
        
        viewModel.$objectViewModel.sink { [weak self] object in
            if !object.galleryObject.isEmpty {
                self?.collectionView.reloadData()
            }
        }.store(in: &subscriptions)
        
        viewModel.$errorMessage.sink { erroMessage in
            // TODO: - Implement the alert
            if erroMessage != "" {
                print(erroMessage)
            }
        }.store(in: &subscriptions)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.objectViewModel.galleryObject.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell
                .identifier, for: indexPath)
                as? GalleryCollectionViewCell else { return UICollectionViewCell() }
    
        // Configure the cell
        cell.updateViewInformations(galleryObject: viewModel.objectViewModel.galleryObject[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.objectViewModel.galleryObject.count - 1 {
            page += 1
            performAPIRequest(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}
