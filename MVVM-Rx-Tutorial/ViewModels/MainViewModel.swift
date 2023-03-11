//
//  MainViewModel.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import Foundation
import RxSwift

final class MainViewModel {
    let title = "News"
    
    private let ariticleServise: ArticleServiceProtocol
    
    init(ariticleServise: ArticleServiceProtocol) {
        self.ariticleServise = ariticleServise
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        return ariticleServise.fetchNews().map { $0.map { ArticleViewModel(article: $0) }}
    }
}
