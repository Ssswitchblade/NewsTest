//
//  ParsersAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

final class ParsersAssembly: AssemblyProtocol {

    func assemble(container: ContainerProtocol) {
        container.register(RSSNewsParserProtocol.self) { _ in
            RSSNewsParser()
        }
    }
}
