//
//  RootTabBarModuleAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 07.11.2024.
//

import UIKit

final class RootTabBarFlowAssembly: FlowAssemblyProtocol {
    
    struct Result {
        let viewController: UIViewController
    }
    
    private let resolver: ResolverProtocol
    
    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func assemble() -> Result {
        let tabBar = RootTabBarController()
        let router = RootTabBarRouter()
        router.viewController = tabBar

        let presenter = RootTabBarPresenter()
        presenter.output = tabBar
        presenter.router = router

        let interactor = RootTabBarInteractor()
        interactor.output = presenter
        presenter.interactor = interactor

        return Result(viewController: tabBar)
    }
}
