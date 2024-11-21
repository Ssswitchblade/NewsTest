//
//  News.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 11.11.2024.
//

import Foundation

struct NewsModel: NewsDTOProtocol {
    var id: UUID
    var title: String
    var link: String
    var descriptionNews: String
    var pubDate: String
    var imageURL: String?
    var isRead: Bool
    var source: String
}

extension NewsModel {
    init(model : NewsDTOProtocol) {
        self.id = model.id
        self.title = model.title
        self.link = model.link
        self.descriptionNews = model.descriptionNews
        self.pubDate = model.pubDate
        self.imageURL = model.imageURL
        self.isRead = model.isRead
        self.source = model.source
    }
}

extension NewsModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(link)
    }
    
    static func ==(lhs: NewsModel, rhs: NewsModel) -> Bool {
        return lhs.title == rhs.title && lhs.link == rhs.link
    }
}
