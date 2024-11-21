//
//  NewsStorages.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation

protocol NewsStoragesProcol {
    func save(object: NewsDTOProtocol)
    func save(objects: [NewsDTOProtocol])
    func getAll() -> [NewsDTOProtocol]
    func cleareDataBase()
}

final class NewsStorages: NewsStoragesProcol {

    private let newsDTOService: NewsDtoServiceProtocol

    init(newsDTOService: NewsDtoServiceProtocol) {
        self.newsDTOService = newsDTOService
    }

    func save(object: NewsDTOProtocol) {
        newsDTOService.save(object: object)
    }
    
    func save(objects: [NewsDTOProtocol]) {
        newsDTOService.save(objects: objects)
    }
    
    func getAll() -> [NewsDTOProtocol] {
        newsDTOService.getAll()
    }
    
    func cleareDataBase() {
        newsDTOService.cleareDataBase()
    }
    
}
