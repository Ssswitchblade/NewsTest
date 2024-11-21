//
//  AppLaunchManager.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 07.11.2024.
//

import UIKit

protocol AppLaunchManagerProtocol {
    func resolveInitialView()
}

final class AppLaunchManager: AppLaunchManagerProtocol {

    private let modulesAssembly: ViewModulesAssemblyProtocol

    init(modulesAssembly: ViewModulesAssemblyProtocol) {
        self.modulesAssembly = modulesAssembly
    }

    private var window: UIWindow? {
        AppDelegate.rootCoordinator.window
    }

    func resolveInitialView() {
        showTabBar()
    }

    private func showTabBar() {
        let tabBarAssembly: RootTabBarFlowAssembly = modulesAssembly.makeAssembly(for: .tabbar)
        let result = tabBarAssembly.assemble()

        window?.rootViewController = result.viewController
    }
}
