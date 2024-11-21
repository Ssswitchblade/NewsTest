//
//  AppCoordinator.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 07.11.2024.
//

import UIKit

protocol RootCoordinatorProtocol {
    var window: UIWindow? { get set }
    func setupInitial(window: UIWindow?)
}

final class RootCoordinator: RootCoordinatorProtocol {

    var window: UIWindow?

    func setupInitial(window: UIWindow?) {
        self.window = window
        self.window?.rootViewController = RootTabBarController()
        self.window?.makeKeyAndVisible()
    }

    
}
