//
//  GalleryInteractor.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation

class GalleryInteractor {
    var presenter: GalleryInteractorOutput!
    var worker: GalleryWorkerInput!
}

extension GalleryInteractor: GalleryInteractorInput {
    func fetchPhotos(with tag: String, on page: Int) {
        worker.fetchPhotos(with: tag, on: page) { (response) in
            self.presenter.processPhotosResponse(response)
        }
    }
}
