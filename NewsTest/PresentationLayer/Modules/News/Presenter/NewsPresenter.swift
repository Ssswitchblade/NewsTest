//
//  NewsPresenter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

final class NewsPresenter {

    weak var view: NewsViewInput?
    var interactor: NewsInteractorInput?
    var router: NewsRouterInput?
    private var newsModel: NewsModel

    init(newsModel: NewsModel) {
        self.newsModel = newsModel
    }
}

//MARK: NewsViewOutput
extension NewsPresenter: NewsViewOutput {
    func viewIsReady() {
        newsModel.isRead = true
        view?.display(news: newsModel)
        interactor?.viewIsReady(news: newsModel)
    }
}

//MARK: NewsInteractorOutput
extension NewsPresenter: NewsInteractorOutput{
    
}
