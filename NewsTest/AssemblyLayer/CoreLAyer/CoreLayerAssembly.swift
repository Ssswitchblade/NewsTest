//
//  CoreLayerAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

final class CoreLayerAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        let assemblies = makeAssemblies()
        assemblies.forEach { $0.assemble(container: container) }
    }
}

private extension CoreLayerAssembly {

    func makeAssemblies() -> [AssemblyProtocol] {
        [
            ParsersAssembly(),
            DataBaseAssembly(),
        ]
    }
}
