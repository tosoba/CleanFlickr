//
//  APIClient.swift
//  CleanFlickr
//
//  Created by merengue on 26/03/2018.
//  Copyright © 2018 merengue. All rights reserved.
//

import Foundation
import RxSwift

class APIClient {
    func send<T: Codable>(apiRequest: APIRequest, url: URL) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
