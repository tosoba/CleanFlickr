//
//  GalleryPresenter.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation

class GalleryPresenter {
     weak var viewController: GalleryPresenterOutput!
}

extension GalleryPresenter: GalleryInteractorOutput {
    func processPhotosResponse(_ response: Response) {
        let photos = response.photosResponse.photos
        let totalPages = response.photosResponse.totalPages
        viewController.updateTotalPages(with: totalPages)
        viewController.presentPhotos(photos)
    }
}
