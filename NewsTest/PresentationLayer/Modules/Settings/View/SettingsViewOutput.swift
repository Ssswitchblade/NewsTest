//
//  SettingsViewOutput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import Foundation

protocol SettingsViewOutput {
    func viewIsReady()
    func timeIntervalDidChange(value: Int, component: TimeComponent)
    func timeButtonTapped()
    func clearCacheButtonTapped()
    func deleteSourceButtonTapped(cellModel: NewsSourceTableViewCellModel)
    func didTapAddSource(urlString: String)
}
