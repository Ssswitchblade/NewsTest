//
//  NewsDtoService.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

protocol NewsDtoServiceProtocol {
    func save(object: NewsDTOProtocol)
    func save(objects: [NewsDTOProtocol])
    func getAll() -> [NewsDTOProtocol]
    func cleareDataBase()
}

final class NewsDtoService: NewsDtoServiceProtocol {

    private let dataBaseService: DataBaseServiceProtocol

    init(dataBaseService: DataBaseServiceProtocol) {
        self.dataBaseService = dataBaseService
    }

    func save(object: NewsDTOProtocol) {
        dataBaseService.save(object: fillDBModel(object), ofType: DBNews.self)
    }
    
    func save(objects: [NewsDTOProtocol]) {
        let models = objects.map { fillDBModel($0)}
        dataBaseService.save(objects: models, ofType: DBNews.self)
    }
    
    func getAll() -> [NewsDTOProtocol] {
        dataBaseService.getAll(ofType: DBNews.self) { [weak self] result in
            guard let self else {
                return []
            }
            let resultArray = result.map { self.fillModel($0) }
            return resultArray
        }
    }
    
    func cleareDataBase() {
        dataBaseService.clearDataBase(ofType: DBNews.self)
    }

}

extension NewsDtoService {

    func fillDBModel(_ model: NewsDTOProtocol) -> DBNews {
        let dbModel = DBNews()
        dbModel.id = model.id
        dbModel.descriptionNews = model.descriptionNews
        dbModel.link = model.link
        dbModel.pubDate = model.pubDate
        dbModel.title = model.title
        dbModel.source = model.source
        dbModel.isRead = model.isRead
        dbModel.imageURL = model.imageURL
        return dbModel
    }

    func fillModel(_ model: DBNews) -> NewsModel {
        return NewsModel(
            id: model.id,
            title: model.title,
            link: model.link,
            descriptionNews: model.descriptionNews,
            pubDate: model.pubDate,
            imageURL: model.imageURL,
            isRead: model.isRead,
            source: model.source
        )
    }
}
