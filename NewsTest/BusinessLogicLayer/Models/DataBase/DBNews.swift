//
//  DBNews.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation
import RealmSwift

final class DBNews: Object, NewsDTOProtocol {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var pubDate: String
    @Persisted var imageURL: String?
    @Persisted var isRead: Bool
    @Persisted var descriptionNews: String
    @Persisted var source: String
}
