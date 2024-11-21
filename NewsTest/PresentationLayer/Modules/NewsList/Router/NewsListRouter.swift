//
//  NewsListRouter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import UIKit

final class NewsListRouter {

    private let modulesAssembly: ViewModulesAssemblyProtocol
    weak var viewController: UIViewController?

    init(modulesAssembly: ViewModulesAssemblyProtocol) {
        self.modulesAssembly = modulesAssembly
    }
}

//MARK: NewsListRouterInput
extension NewsListRouter: NewsListRouterInput {

    func presentNewsViewModel(_ newsModel: NewsModel) {
        let assembly: NewsAssembly = modulesAssembly.makeAssembly(for: .news(model: newsModel))
        let result = assembly.assemble()
        viewController?.navigationController?.pushViewController(result.viewController, animated: true)
    }
}
