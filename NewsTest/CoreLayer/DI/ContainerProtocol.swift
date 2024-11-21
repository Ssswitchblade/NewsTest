//
//  ContainerProtocol.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation
import Swinject

enum DIObjectScope {
    case container
    case graph
    case transient

    var toObjectScope: ObjectScope {
        switch self {
        case .container: return .container
        case .graph: return .graph
        case .transient: return .transient
        }
    }
}

protocol ContainerProtocol {
    var resolver: ResolverProtocol { get }

    func register<Service>(_ serviceType: Service.Type,
                           factory: @escaping (ResolverProtocol) -> Service)
    func register<Service>(_ serviceType: Service.Type,
                           scope: DIObjectScope,
                           factory: @escaping (ResolverProtocol) -> Service)
    
    func register<Service>(_ serviceType: Service.Type,
                           name: String,
                           factory: @escaping (ResolverProtocol) -> Service)
    
    func register<Service>(_ serviceType: Service.Type,
                           name: String,
                           scope: DIObjectScope,
                           factory: @escaping (ResolverProtocol) -> Service)
}

protocol ResolverProtocol {
    func resolve<Service>(_ serviceType: Service.Type) -> Service
    func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service
}
