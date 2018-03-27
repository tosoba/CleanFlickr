//
//  GalleryContract.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryRouterInput {
    func showPhotoViewController()
    func passPhoto(_ photo: Photo, for segue: UIStoryboardSegue)
}

protocol GalleryWorkerInput {
    func fetchPhotos(with tag: String, on page: Int, onResult: @escaping (Response) -> Void)
}

protocol GalleryInteractorInput: class {
    func fetchPhotos(with tag: String, on page: Int)
}

protocol GalleryInteractorOutput: class {
    func processPhotosResponse(_ response: Response)
}

protocol GalleryPresenterOutput: class {
    func presentPhotos(_ photos: [Photo])
    func updateTotalPages(with value: Int)
}

protocol GalleryViewControllerInput: GalleryPresenterOutput {
    
}
