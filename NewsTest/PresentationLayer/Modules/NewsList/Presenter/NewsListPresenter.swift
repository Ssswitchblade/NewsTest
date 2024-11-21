//
//  NewsListPresenter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import UIKit

final class NewsListPresenter {
    
    weak var view: NewsListViewInput?
    var interactor: NewsListIntetactorInput?
    var router: NewsListRouterInput?

    private var presentedNews = [NewsModel]()

}

//MARK: NewsListViewOutput
extension NewsListPresenter: NewsListViewOutput {
    func viewIsReady() {
        interactor?.viewIsReady()
    }

    func didSelectNews(at: Int) {
        router?.presentNewsViewModel(presentedNews[at])
        presentedNews[at].isRead = true
        let cellModels: Array<NewsTableViewCellModel> = presentedNews.map { .init(id: $0.id, title: $0.title, imageURL: $0.imageURL, isRead: $0.isRead) }
        view?.displayNewModels(news: cellModels, animated: false)
    }

}

//MARK: NewsListInteractorOutput
extension NewsListPresenter: NewsListInteractorOutput {
    func presentNews(_ models: [NewsDTOProtocol]) {
        var unigueNews = getUniqueNews(from: models)
        unigueNews = sortNewsByDate(news: unigueNews)
        presentedNews.insert(contentsOf: unigueNews, at: 0)
        let cellModels: Array<NewsTableViewCellModel> = presentedNews.map { .init(id: $0.id, title: $0.title, imageURL: $0.imageURL, isRead: $0.isRead) }
        guard cellModels.count > 0 else { return }
        view?.displayNewModels(news: cellModels, animated: true)
    }
}

extension NewsListPresenter {
    func getUniqueNews(from models: [NewsDTOProtocol]) -> [NewsModel] {
        let modelSet = Set(models.map { NewsModel(model: $0) })
        return Array(modelSet).filter { !presentedNews.contains($0) }
    }
    
    func sortNewsByDate(news: [NewsModel]) -> [NewsModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        
        return news.sorted { first, second in
            guard let firstDate = dateFormatter.date(from: first.pubDate),
                  let secondDate = dateFormatter.date(from: second.pubDate) else {
                return false
            }
            return firstDate > secondDate
        }
    }
}
