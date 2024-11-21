//
//  SettingsViewInput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import UIKit

protocol SettingsViewInput: AnyObject {
    func viewTimeInterval(_ interval: TimeInterval)
    func updateTimerButton(isWork: Bool)
    func displayNewsSources(sections: NSDiffableDataSourceSnapshot<Int, NewsSourceTableViewCellModel>)
}
