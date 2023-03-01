//
//  ArticleService.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import Foundation
import Alamofire

class ArticleService {
    func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything"
        
        let param = [
            "q" : "tesla",
            "sortBy" : "publishedAt",
            "apiKey" : "bc83fae28aeb4e07ab75f770c6b23bb6"
        ]
        
        AF.request(urlString,
                   method: HTTPMethod.get,
                   parameters: param,
                   encoding: JSONEncoding.default)
        .responseDecodable(of: ArticleResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.Article))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
