//
//  MainScreenAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import UIKit

final class NewsListAssembly: FlowAssemblyProtocol {

    struct Result {
        let viewController: UIViewController
    }

    private let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func assemble() -> Result {
        let viewController = NewsListViewController()
        let router = NewsListRouter(modulesAssembly: resolver.resolve(ViewModulesAssemblyProtocol.self))
        let presenter = NewsListPresenter()

        let newsRepository = resolver.resolve(NewsRepositoryProtocol.self)
        let interactor = NewsListInteractor(newsRepository: newsRepository)

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        viewController.output = presenter
        interactor.output = presenter
        router.viewController = viewController

        return Result(viewController: viewController)
    }
}
