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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
        addItensToView()
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
        viewModel.$isLoading.sink { [weak self] loading in
            if loading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }.store(in: &subscriptions)
        
        viewModel.$objectViewModel.sink { [weak self] object in
            if !object.galleryObject.isEmpty {
                self?.collectionView.reloadData()
            }
        }.store(in: &subscriptions)
        
        viewModel.$errorMessage.sink { [weak self] erroMessage in
            if erroMessage != "" {
                self?.showAlert(title: "Error", message: erroMessage)
            }
        }.store(in: &subscriptions)
    }
    
    /// Function responsible to add itens to our view
    private func addItensToView() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: view
            .centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view
            .centerXAnchor).isActive = true
        
    }
    
    /// Function responsible to show an alert to the user
    /// - Parameters:
    ///   - title: can receive a alert title to show
    ///   - message: must receive a message to indicate the status for the user
    private func showAlert(title: String? = nil, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.navigationController?.dismiss(animated: true)
        }
        alertController.addAction(action)

        navigationController?.present(alertController, animated: true)
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
