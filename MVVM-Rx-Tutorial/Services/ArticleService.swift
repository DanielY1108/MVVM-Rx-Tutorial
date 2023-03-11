//
//  ArticleService.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { observer in
            
            self.fetchNews { result in
                switch result {
                case .success(let articles):
                    observer.onNext(articles)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything"
        
        let param = [
            "q" : "tesla",
            "sortBy" : "publishedAt",
            "apiKey" : "bc83fae28aeb4e07ab75f770c6b23bb6"
        ]
       
        AF.request(urlString,
                   method: HTTPMethod.get,
                   parameters: param,
                   encoding: URLEncoding.default)
        .responseDecodable(of: ArticleResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
