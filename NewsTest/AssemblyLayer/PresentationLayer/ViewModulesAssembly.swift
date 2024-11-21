//
//  ViewModulesAssembly.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation

enum ViewModule {
    case tabbar
    case newsList
    case settings
    case news(model: NewsModel)
}

protocol FlowAssemblyProtocol {
    associatedtype Result
    
    func assemble() -> Result
}

protocol ViewModulesAssemblyProtocol {
    func makeAssembly<Assembly: FlowAssemblyProtocol>(for module: ViewModule) -> Assembly
}

final class ViewModulesAssembly: ViewModulesAssemblyProtocol {
    
    private let resolver: ResolverProtocol
    
    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
    
    func makeAssembly<Assembly: FlowAssemblyProtocol>(for module: ViewModule) -> Assembly {
        switch module {
            //Assembly RootTabBar
        case .tabbar:
            guard let assembly = RootTabBarFlowAssembly(resolver: resolver) as? Assembly else {
                fatalError("Failed to cast")
            }
            return assembly
            
            //Assembly NewsListFlow
        case .newsList:
            guard let assembly = NewsListAssembly(resolver: resolver) as? Assembly else {
                fatalError("Failed to cast")
            }
            return assembly
            
            //Assembly Settings
        case .settings:
            guard let assembly = SettingsAssembly(resolver: resolver) as? Assembly else {
                fatalError("Failed to cast")
            }
            return assembly

            // Assembly News
        case .news(let models):
            guard let assembly = NewsAssembly(resolver: resolver, newsModel: models) as? Assembly else {
                fatalError("Failed to cast")
            }
            return assembly
        }
    }
    
}
