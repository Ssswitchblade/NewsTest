//
//  PresentationLayerAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation

final class PresentationLayerAssembly: AssemblyProtocol {
    
    func assemble(container: ContainerProtocol) {
        container.register(ViewModulesAssemblyProtocol.self) { resolver in
            ViewModulesAssembly(resolver: resolver)
        }

        container.register(RootCoordinatorProtocol.self, scope: .container) { resolver in
            RootCoordinator()
        }
    }
}
