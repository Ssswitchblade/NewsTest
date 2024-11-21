//
//  NewsListInteractor.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation
import Combine

final class NewsListInteractor {
    
    weak var output: NewsListInteractorOutput?

    private let newsRepository: NewsRepositoryProtocol

    private var canceballes = Set<AnyCancellable>()

    init(newsRepository: NewsRepositoryProtocol) {
        self.newsRepository = newsRepository
    }

    
}

//MARK: NewsListIntetactorInput
extension NewsListInteractor: NewsListIntetactorInput {
    func viewIsReady() {
        subscribe()
        output?.presentNews(newsRepository.getNews()) 
    }
}

extension NewsListInteractor {
    func subscribe() {
        newsRepository.newsObsevable.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("Timer success")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }, receiveValue: { [weak self] value in
            self?.output?.presentNews(value)
        }).store(in: &canceballes)
    }

}
