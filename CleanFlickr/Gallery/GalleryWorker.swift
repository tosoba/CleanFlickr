//
//  GalleryWorker.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation
import RxSwift

class GalleryWorker {
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    struct FlickrAPI {
        static let apiKey = "f94f6fb45e2c100d75bebc8e3377fa17"
        static let baseURL = URL(string: "https://api.flickr.com/")!
    }
    
    struct PhotosRequest: APIRequest {
        var method = RequestType.GET
        var path = "services/rest"
        var parameters = ["method": "flickr.photos.search", "api_key": FlickrAPI.apiKey, "format": "json", "nojsoncallback": "1"]
    }
    
    private func makeRequest(with tag: String, for page: Int) -> APIRequest {
        var request = PhotosRequest()
        request.parameters["tags"] = tag
        request.parameters["page"] = String(page)
        return request
    }
}

extension GalleryWorker: GalleryWorkerInput {
    func fetchPhotos(with tag: String, on page: Int, onResult: @escaping (Response) -> Void) {
        let request = makeRequest(with: tag, for: page)
        Observable
            .just(request)
            .flatMap { (request) -> Observable<Response> in
                return self.apiClient.send(apiRequest: request, url: FlickrAPI.baseURL)
            }
            .subscribe { (event) in
                guard let data = event.element else {
                    print("No data.")
                    return
                }
                onResult(data)
            }
            .disposed(by: disposeBag)
    }
}
