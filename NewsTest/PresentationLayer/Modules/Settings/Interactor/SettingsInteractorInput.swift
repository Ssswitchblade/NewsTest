//
//  SettingsInteractorInput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import Foundation

protocol SettingsInteractorInput {
    func viewIsRady()
    func timeIntervalDidChange(value: Double)
    func timerUpdated(isWork: Bool)
    func clearCache()
    func deleteNewsSource(_ model: NewsSourceDtoProtocol)
    func addNewsSource(_ model: NewsSourceDtoProtocol)
}
