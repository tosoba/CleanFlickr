//
//  GalleryConfigurator.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation

class GalleryConfigurator {
    static let sharedInstance = GalleryConfigurator()
    private init() {}
    
    func configure(_ viewController: GalleryViewController) {
        let router = GalleryRouter()
        router.viewController = viewController
        
        let presenter = GalleryPresenter()
        presenter.viewController = viewController
        
        let interactor = GalleryInteractor()
        interactor.presenter = presenter
        interactor.worker = GalleryWorker()
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
