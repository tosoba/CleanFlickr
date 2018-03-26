//
//  GalleryModels.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation

struct Response: Codable {
    let photosResponse: PhotosResponse
    let status: String
    
    private enum CodingKeys: String, CodingKey {
        case photosResponse = "photos"
        case status = "stat"
    }
}

struct PhotosResponse: Codable {
    let page: Int
    let totalPages: Int
    let perPage: Int
    let totalPhotos: String
    let photos: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "pages"
        case perPage = "perpage"
        case totalPhotos = "total"
        case photos = "photo"
    }
}

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
    
    var photoUrl: NSURL {
        return urlForPhoto()
    }
    
    var largePhotoUrl: NSURL {
        return urlForPhoto(sized: "b")
    }
    
    private func urlForPhoto(sized size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg")!
    }
}
