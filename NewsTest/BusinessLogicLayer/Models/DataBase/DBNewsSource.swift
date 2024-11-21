//
//  DBNewsSource.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 19.11.2024.
//

import Foundation
import RealmSwift

final class DBNewsSource: Object, NewsSourceDtoProtocol {
    @Persisted var id: String
    @Persisted var sourceUrlString: String

    override class func primaryKey() -> String? {
        return "id"
    }
}
