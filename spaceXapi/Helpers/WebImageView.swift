//
//  WebImageView.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 01.03.2023.
//

import UIKit
import Alamofire

class WebImageView: UIImageView {
    
    private var placeHolder = UIImage(named: "placeHolder")
    private var currentUrlString: String?
    
    func set(imageURL: String?, completion: @escaping () -> Void ) {
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = placeHolder
            completion()
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            //get image in cache
            self.image = UIImage(data: cachedResponse.data)
            completion()
            return
        }
               
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { [weak self] responseData in
                guard let response = responseData.response else { return }
                switch responseData.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if url.description == self?.currentUrlString {
                            self?.handleLoadedImage(data: data, response: response)
                            completion()
                        }
                    }
                case .failure(let error):
                    //TODO: Обработка ошибки
                    self?.image = self?.placeHolder
                    completion()
                    print(error.localizedDescription)
                }
            }
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
    
}
