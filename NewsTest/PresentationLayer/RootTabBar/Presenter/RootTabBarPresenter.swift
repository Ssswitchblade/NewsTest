//
//  RootTabBarPresenter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 07.11.2024.
//

import Foundation

final class RootTabBarPresenter {

    var router: RootTabBarRouterInput?
    weak var output: RootTabBarViewInput?
    var interactor: RootTabBarInteractorInput?

}

//MARK: RootTabBarViewOutput
extension RootTabBarPresenter: RootTabBarViewOutput {}

//MARK: RootTabBarInteractorOutput
extension RootTabBarPresenter: RootTabBarInteractorOutput {}
