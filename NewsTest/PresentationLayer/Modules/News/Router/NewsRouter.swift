//
//  NewsRouter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

import UIKit

final class NewsRouter {

    weak var viewController: UIViewController?
    private let modulesAssembly: ViewModulesAssemblyProtocol

    init(modulesAssembly: ViewModulesAssemblyProtocol) {
        self.modulesAssembly = modulesAssembly
    }
}

//MARK: NewsRouterInput
extension NewsRouter: NewsRouterInput {
    
}
