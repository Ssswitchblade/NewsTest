//
//  NewsViewInput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

import Foundation

protocol NewsViewInput: AnyObject {
    func display(news: NewsModel)
}
