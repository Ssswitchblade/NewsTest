//
//  SettingsAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import UIKit

final class SettingsAssembly: FlowAssemblyProtocol {
    struct Result {
        let viewController: UIViewController
    }

    private let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func assemble() -> Result {
        let viewController = SettingsViewController()
        let router = SettingsRouter()
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(newsRepository: resolver.resolve(NewsRepositoryProtocol.self))

        viewController.output = presenter
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.output = presenter

        return Result(viewController: viewController)
    }
}
