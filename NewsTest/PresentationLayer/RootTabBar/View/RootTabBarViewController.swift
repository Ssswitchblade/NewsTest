//
//  TabBarViewController.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 07.11.2024.
//

import UIKit

final class RootTabBarController: UITabBarController {

    var output: RootTabBarViewOutput?

    private let modulesAssembly = AppDelegate.resolver.resolve(ViewModulesAssemblyProtocol.self)

    private var availableTabs: Array<UINavigationController> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupNewsListTab()
        setupSettingsTab()
        viewControllers = availableTabs
    }

    private func setupNewsListTab() {
        let assembly: NewsListAssembly = modulesAssembly.makeAssembly(for: .newsList)
        let result = assembly.assemble()
        
        let navigationController = UINavigationController(rootViewController: result.viewController)
        navigationController.tabBarItem.image = UIImage(systemName: "newspaper")
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")
        availableTabs.append(navigationController)
    }

    private func setupSettingsTab() {
        let assembly: SettingsAssembly = modulesAssembly.makeAssembly(for: .settings)
        let result = assembly.assemble()
        
        let navigationController = UINavigationController(rootViewController: result.viewController)
        navigationController.tabBarItem.image = UIImage(systemName: "gearshape")
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        availableTabs.append(navigationController)
    }

}

//MARK: RootTabBarViewInput
extension RootTabBarController: RootTabBarViewInput {
    
}
