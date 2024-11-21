//
//  NewsSourceStorage.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 19.11.2024.
//

protocol NewsSourceStoragesProtocol {
    func save(object: NewsSourceDtoProtocol)
    func save(objects: [NewsSourceDtoProtocol])
    func getAll() -> [NewsSourceDtoProtocol]
    func delete(object: NewsSourceDtoProtocol)
    func cleareDataBase()
}

final class NewsSourceStorage: NewsSourceStoragesProtocol {

    private let newsDTOService: NewsSourceDtoServiceProtocol

    init(newsDTOService: NewsSourceDtoServiceProtocol) {
        self.newsDTOService = newsDTOService
    }

    func save(object: any NewsSourceDtoProtocol) {
        newsDTOService.save(object: object)
    }
    
    func save(objects: [any NewsSourceDtoProtocol]) {
        newsDTOService.save(objects: objects)
    }
    
    func getAll() -> [any NewsSourceDtoProtocol] {
        newsDTOService.getAll()
    }

    func delete(object: any NewsSourceDtoProtocol) {
        newsDTOService.delete(object: object)
    }

    func cleareDataBase() {
        newsDTOService.cleareDataBase()
    }
}
