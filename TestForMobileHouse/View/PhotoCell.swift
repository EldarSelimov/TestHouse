//
//  PhotoCell.swift
//  TestForMobileHouse
//
//  Created by Eldar on 03.09.2021.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    
    private let photoImageVIew: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["thumb"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            photoImageVIew.sd_setImage(with: url, completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageVIew.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPhotoImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPhotoImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageVIew)
        photoImageVIew.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageVIew.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageVIew.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
}
