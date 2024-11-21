//
//  ManagersAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import Foundation

final class ManagersAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        container.register(AppLaunchManagerProtocol.self, scope: .container) { resolver in
            AppLaunchManager(
                modulesAssembly: resolver.resolve(ViewModulesAssemblyProtocol.self)
            )
        }
    }

}
