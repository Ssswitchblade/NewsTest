//
//  DIContainer.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//


import Swinject

final class DIContainer: ContainerProtocol {
    private let container = Container()

    var resolver: ResolverProtocol {
        DIResolver(resolver: container.synchronize())
    }
    
    func register<Service>(_ serviceType: Service.Type,
                           factory: @escaping (ResolverProtocol) -> Service) {
        register(serviceType, scope: .graph, factory: factory)
    }
    
    func register<Service>(_ serviceType: Service.Type,
                           name: String,
                           factory: @escaping (ResolverProtocol) -> Service) {
        register(serviceType, name: name, scope: .graph, factory: factory)
    }

    func register<Service>(_ serviceType: Service.Type,
                           scope: DIObjectScope,
                           factory: @escaping (ResolverProtocol) -> Service) {
        container.register(
            serviceType,
            factory: { resolver in
                factory(DIResolver(resolver: resolver))
            }
        ).inObjectScope(scope.toObjectScope)
    }
    
    func register<Service>(_ serviceType: Service.Type,
                           name: String,
                           scope: DIObjectScope,
                           factory: @escaping (ResolverProtocol) -> Service) {
        container.register(
            serviceType,
            name: name,
            factory: { resolver in
                factory(DIResolver(resolver: resolver))
            }
        ).inObjectScope(scope.toObjectScope)
    }
}

// MARK: - ResolverProtocol
extension DIContainer: ResolverProtocol {
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.synchronize().resolve(serviceType) else {
            fatalError("Failed to resolve service")
        }

        return service
    }
    
    func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service {
        guard let service = container.synchronize().resolve(serviceType, name: name) else {
            fatalError("Failed to resolve service with name: \(name)")
        }

        return service
    }
}

final class DIResolver: ResolverProtocol {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = resolver.resolve(serviceType) else {
            fatalError("Failed to resolve service: \(serviceType)")
        }

        return service
    }
    
    func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service {
        guard let service = resolver.resolve(serviceType, name: name) else {
            fatalError("Failed to resolve service with name: \(name)")
        }

        return service
    }
}
