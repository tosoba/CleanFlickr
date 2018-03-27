//
//  GalleryRouter.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation
import UIKit

class GalleryRouter {
    weak var viewController: UIViewController!
    
    static let showPhotoSegueIdentifier = "ShowPhotoSegue"
}

extension GalleryRouter: GalleryRouterInput {
    func showPhotoViewController() {
        viewController.performSegue(withIdentifier: GalleryRouter.showPhotoSegueIdentifier, sender: nil)
    }
    
    func passPhoto(_ photo: Photo, for segue: UIStoryboardSegue) {
        if segue.identifier == GalleryRouter.showPhotoSegueIdentifier {
            let destinationVC = segue.destination as! PhotoViewController
            destinationVC.photo = photo
        }
    }
}
