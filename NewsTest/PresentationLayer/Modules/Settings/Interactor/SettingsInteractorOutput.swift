//
//  SettingsInteractorOutput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import UIKit

protocol SettingsInteractorOutput: AnyObject {
    func presentTimeInterval(_ interval: TimeInterval)
    func presentNewsSourcesInitial(_ models: [NewsSourceDtoProtocol])
}
