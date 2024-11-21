//
//  NewsListViewOutput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation

protocol NewsListViewOutput {
    func viewIsReady()
    func didSelectNews(at: Int)
}
