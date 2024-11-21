//
//  BusinessLogicLayerAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import Foundation

final class BusinessLogicLayerAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        let assemblies = makeAssembly()
        assemblies.forEach { $0.assemble(container: container)}
    }
}

private extension BusinessLogicLayerAssembly {

    func makeAssembly() -> [AssemblyProtocol] {
        [
        ManagersAssembly(),
        RepositoriesAssembly(),
        ServicesAssembly(),
        StoragesAssembly(),
        ]
    }
}
