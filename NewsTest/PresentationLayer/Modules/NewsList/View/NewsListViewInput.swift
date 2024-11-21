//
//  NewsListViewInput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import UIKit

protocol NewsListViewInput: AnyObject {
    func displayNewModels(news: [NewsTableViewCellModel], animated: Bool)
    func displayReload(id: UUID)
}
