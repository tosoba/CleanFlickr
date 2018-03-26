//
//  GalleryCollectionViewCell.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}
