//
//  NewsRestModel.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 11.11.2024.
//

import Foundation

struct NewsRestModel: NewsDTOProtocol {
    var id: UUID
    
    var descriptionNews: String
    
    var source: String
    
    var title: String
    
    var link: String
    
    var pubDate: String
    
    var imageURL: String?
    
    var isRead: Bool
}
