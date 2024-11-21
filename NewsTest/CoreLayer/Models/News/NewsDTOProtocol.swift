//
//  NewsDTOProtocol.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 11.11.2024.
//

import Foundation

protocol NewsDTOProtocol {
    var id: UUID { get }
    var title: String { get }
    var link: String { get }
    var descriptionNews: String { get }
    var pubDate: String { get }
    var imageURL: String? { get }
    var isRead: Bool { get set }
    var source: String { get }
}
