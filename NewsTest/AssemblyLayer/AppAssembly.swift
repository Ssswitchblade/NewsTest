//
//  AppAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

final class AppAssembly: AssemblyProtocol {
    
    func assemble(container: ContainerProtocol) {
        let assemblies = makeAssemblies()
        assemblies.forEach {
            $0.assemble(container: container)
        }
    }
}

private extension AppAssembly {
    
    func makeAssemblies() -> [AssemblyProtocol] {
        [
            PresentationLayerAssembly(),
            BusinessLogicLayerAssembly(),
            CoreLayerAssembly(),
        ]
    }
}
