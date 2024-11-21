//
//  DataBaseAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 15.11.2024.
//

import Foundation

final class DataBaseAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        container.register(DataBaseServiceProtocol.self, scope: .container) { _ in
            DataBaseService()
        }

        container.register(NewsDtoServiceProtocol.self) { resolver in
            NewsDtoService(
                dataBaseService: resolver.resolve(DataBaseServiceProtocol.self)
            )
        }

        container.register(NewsSourceDtoServiceProtocol.self) { resolver in
            NewsSourceDtoService(
                dataBaseService: resolver.resolve(DataBaseServiceProtocol.self)
            )
        }
    }
}
