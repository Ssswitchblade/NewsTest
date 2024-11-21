//
//  NewsSource.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 19.11.2024.
//
import Foundation

struct NewsSource: NewsSourceDtoProtocol {
    let id: String
    let sourceUrlString: String
}

extension NewsSource {
    init(model: NewsSourceDtoProtocol) {
        self.id = model.id
        self.sourceUrlString = model.sourceUrlString
    }
}

