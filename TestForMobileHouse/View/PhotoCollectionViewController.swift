//
//  PhotoCollectionViewController.swift
//  TestForMobileHouse
//
//  Created by Eldar on 03.09.2021.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    var searchTF: ViewController!
    
    private var timer: Timer?
    
    var searchText = ""
    
    private var photos = [UnsplashPhoto]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ответ на ваш запрос: \(searchText)"
        
        loadingImage()
    }
    
    func loadingImage() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: self.searchText) { [weak self] (searchResults) in
                guard let fetchPhotos = searchResults else { return }
                self?.photos = fetchPhotos.results
                self?.collectionView.reloadData()
            }
        })
    }
    
// MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        DispatchQueue.main.async {
            let unsplashPhoto = self.photos[indexPath.item]
            cell.unsplashPhoto = unsplashPhoto
        }
        
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInserts.left
    }
}
