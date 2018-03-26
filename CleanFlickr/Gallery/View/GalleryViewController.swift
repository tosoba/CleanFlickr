//
//  GalleryViewController.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var photosSearchBar: UISearchBar!
    
    var interactor: GalleryInteractorInput!
    var router: GalleryRouterInput!
    
    private var photos: [Photo] = []
    private var currentPage = 1
    private var totalPages = 1
    
    private var lastSearchedTag = "" {
        didSet {
            if oldValue != lastSearchedTag {
                shouldClearPhotos = true
            }
        }
    }
    
    private var shouldClearPhotos = false

    override func awakeFromNib() {
        super.awakeFromNib()
        GalleryConfigurator.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosSearchBar.delegate = self
    }

}

extension GalleryViewController: GalleryViewControllerInput {
    func presentPhotos(_ photos: [Photo]) {
        if shouldClearPhotos == true {
            self.photos.removeAll()
        }
        
        self.photos.append(contentsOf: photos)
        
        DispatchQueue.main.async {
            self.photosCollectionView.reloadData()
        }
    }
    
    func updateTotalPages(with value: Int) {
        self.totalPages = value
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentPage < totalPages {
            return photos.count // all photo cells + loading cell
        }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < photos.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            let photo = self.photos[indexPath.row]
            cell.photoImageView.alpha = 0
            cell.photoImageView.sd_setImage(with: photo.photoUrl as URL, placeholderImage: nil, options: .cacheMemoryOnly, progress: nil, completed: { (image, error, cacheType, url) in
                cell.photoImageView.image = image
                UIView.animate(withDuration: 0.2, animations: {
                    cell.photoImageView.alpha = 1.0
                })
            })
            
            return cell
        } else {
            currentPage += 1
            shouldClearPhotos = false
            interactor.fetchPhotos(with: lastSearchedTag, on: currentPage)
            return collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewLoadingCell", for: indexPath)
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // segue
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize: CGSize
        let length = UIScreen.main.bounds.width / 3 - 1
        if indexPath.row < photos.count {
            itemSize = CGSize(width: length, height: length)
        } else {
            itemSize = CGSize(width: photosCollectionView.bounds.width, height: 50.0)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension GalleryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let tag = searchBar.text else { return }
        if tag.isEmpty { return }
        
        lastSearchedTag = tag
        interactor.fetchPhotos(with: tag, on: currentPage)
    }
}

