//
//  RepositoriesAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

final class RepositoriesAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        container.register(NewsRepositoryProtocol.self, scope: .container) { resolver in
            NewsRepository(
                newsRestService: resolver.resolve(NewsRestServiceProtocol.self),
                newsStorage: resolver.resolve(NewsStoragesProcol.self),
                newsSourceStorage: resolver.resolve(NewsSourceStoragesProtocol.self)
            )
        }
    }
}
