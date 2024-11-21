//
//  ServicesAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

final class ServicesAssembly: AssemblyProtocol {
    
    func assemble(container: ContainerProtocol) { 
        container.register(NewsRestServiceProtocol.self) { resolver in
            NewsRestService(
                newsParser: resolver.resolve(RSSNewsParserProtocol.self)
            )
        }
    }
}
