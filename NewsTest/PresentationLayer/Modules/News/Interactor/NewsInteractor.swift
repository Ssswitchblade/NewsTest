//
//  NewsInteractor.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

import Foundation

final class NewsInteractor {

    weak var output: NewsInteractorOutput?

    private let newsRepository: NewsRepositoryProtocol

    init(newsRepository: NewsRepositoryProtocol) {
        self.newsRepository = newsRepository
    }
}

//MARK: NewsInteractorInput
extension NewsInteractor: NewsInteractorInput {
    func viewIsReady(news: NewsModel) {
        newsRepository.updateNews(model: news)
    }
}

