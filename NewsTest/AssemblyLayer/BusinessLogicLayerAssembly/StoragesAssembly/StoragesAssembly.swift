//
//  StoragesAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 15.11.2024.
//

import Foundation

final class StoragesAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        container.register(NewsStoragesProcol.self) { resolver in
            NewsStorages(
                newsDTOService: resolver.resolve(NewsDtoServiceProtocol.self)
            )
        }

        container.register(NewsSourceStoragesProtocol.self) { resolver in
            NewsSourceStorage(
                newsDTOService: resolver.resolve(NewsSourceDtoServiceProtocol.self)
            )
        }
    }
}
