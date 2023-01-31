//
//  GalleryCollectionViewCell.swift
//  Imgur
//
//  Created by Daniel Griso Filho on 28/01/23.
//

import UIKit
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables and Properties
    static let identifier = "\(GalleryCollectionViewCell.self)"
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image:
                                        UIImage(systemName:
                                                    "icloud.and.arrow.down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addItensToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Intenal Functions
    private func addItensToView() {
        
        contentView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: contentView
            .centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView
            .centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView
            .heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView
            .widthAnchor).isActive = true
    }
    
    func updateViewInformations(galleryObject object: GalleryObject) {
        
        if let url = URL(string: object.imageLink) {
            if object.imageLink.contains(".mp4") {
                imageView.image = UIImage(systemName: "play.circle")?
                    .withTintColor(.white, renderingMode: .alwaysOriginal)
                imageView.backgroundColor = .black
            } else {
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
