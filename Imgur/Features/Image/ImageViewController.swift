//
//  ImageViewController.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 30/01/23.
//

import UIKit
import AVKit
import AVFoundation
import SDWebImage

class ImageViewController: UIViewController {
    
    // MARK: - Variables and Properties
    var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    var playerController: AVPlayerViewController = {
        let controller = AVPlayerViewController()
        return controller
    }()
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image:
                                        UIImage(systemName:
                                                    "icloud.and.arrow.down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let imageTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    var object: GalleryObject?
    
    // MARK: - Life cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        addComponentsToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewInformations(galleryObject: object)
    }
    
    // MARK: - Intenal Functions
    
    /// Function responsible to add itens to our view
    private func addComponentsToView() {
        view.addSubview(imageTitleLabel)
        
        imageTitleLabel.topAnchor.constraint(equalTo: view
            .safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        imageTitleLabel.leadingAnchor.constraint(equalTo: view
            .leadingAnchor, constant: 8).isActive = true
        imageTitleLabel.trailingAnchor.constraint(equalTo: view
            .trailingAnchor, constant: -8).isActive = true
        imageTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    /// Function responsible to add the image view to our view
    private func addImageViewToView() {
        
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: imageTitleLabel
            .bottomAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageTitleLabel
            .leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageTitleLabel
            .trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide
            .bottomAnchor, constant: -8).isActive = true
    }
    /// Function responsible to add the player view to our view
    private func addVideoPlayerToView() {
        view.addSubview(videoView)
        
        videoView.topAnchor.constraint(equalTo: imageTitleLabel
            .bottomAnchor, constant: 8).isActive = true
        videoView.leadingAnchor.constraint(equalTo: imageTitleLabel
            .leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: imageTitleLabel
            .trailingAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide
            .bottomAnchor, constant: -8).isActive = true
        
        videoView.addSubview(playerController.view)
        playerController.view.frame.size.height = videoView.frame.size.height
        playerController.view.frame.size.width = videoView.frame.size.width
    }
    
    /// Function responsible to update the itens on our view
    /// - Parameter object: receive the obect comes from the API
    private func updateViewInformations(galleryObject object: GalleryObject?) {
        
        imageTitleLabel.text = object?.title
        
        if let url = URL(string: object?.imageLink ?? "") {
            if (object?.imageLink.contains(".mp4") ?? false) {
                addVideoPlayerToView()

                player = AVPlayer(url: url)
                
                playerController.player = player
                player.play()
                
            } else {
                addImageViewToView()
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.sd_setImage(with: url,
                                                placeholderImage:
                                                    UIImage(systemName:
                                                                "icloud.and.arrow.down"))
                }
            }
        }
    }

}
