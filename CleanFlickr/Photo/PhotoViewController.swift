//
//  PhotoViewController.swift
//  CleanFlickr
//
//  Created by merengue on 27/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()

        setPhotoForImageView()
        photoTitleLabel.text = photo.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setPhotoForImageView() {
        photoImageView.sd_setImage(with: photo.largePhotoUrl as URL, placeholderImage: nil, options: .cacheMemoryOnly, progress: nil, completed: { (image, error, cacheType, url) in
            self.photoImageView.image = image
            UIView.animate(withDuration: 0.2, animations: {
                self.photoImageView.alpha = 1.0
            })
        })
    }
}
