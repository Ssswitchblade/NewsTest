//
//  NewsAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

import UIKit

final class NewsAssembly: FlowAssemblyProtocol {

    struct Result {
        let viewController: UIViewController
    }

    private let resolver: ResolverProtocol
    private let newsModel: NewsModel

    init(resolver: ResolverProtocol, newsModel: NewsModel) {
        self.resolver = resolver
        self.newsModel = newsModel
    }

    func assemble() -> Result {
        let view = NewsViewController()
        let interactor = NewsInteractor(newsRepository: resolver.resolve(NewsRepositoryProtocol.self))
        let router = NewsRouter(modulesAssembly: resolver.resolve(ViewModulesAssemblyProtocol.self))

        let presenter = NewsPresenter(newsModel: newsModel)
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.output = presenter
        interactor.output = presenter
        return Result(viewController: view)
    }
}
