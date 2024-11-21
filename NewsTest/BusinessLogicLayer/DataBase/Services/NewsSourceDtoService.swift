//
//  NewsSourceDTOService.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 19.11.2024.
//

protocol NewsSourceDtoServiceProtocol {
    func save(object: NewsSourceDtoProtocol)
    func save(objects: [NewsSourceDtoProtocol])
    func getAll() -> [NewsSourceDtoProtocol]
    func delete(object: NewsSourceDtoProtocol)
    func cleareDataBase()
}

final class NewsSourceDtoService: NewsSourceDtoServiceProtocol {

    private let dataBaseService: DataBaseServiceProtocol

    init(dataBaseService: DataBaseServiceProtocol) {
        self.dataBaseService = dataBaseService
    }

    func save(object: any NewsSourceDtoProtocol) {
        save(objects: [fillDBModel(object)])
    }
    
    func save(objects: [any NewsSourceDtoProtocol]) {
        let dbObjects = objects.map { fillDBModel($0) }
        dataBaseService.save(objects: dbObjects, ofType: DBNewsSource.self)
    }
    
    func getAll() -> [any NewsSourceDtoProtocol] {
        dataBaseService.getAll(ofType: DBNewsSource.self) { [weak self] result in
            guard let self else {
                return [] }
            let modelsArray = result.map { self.fillModel($0) }
            return modelsArray
        }
    }

    func delete(object: any NewsSourceDtoProtocol) {
        dataBaseService.deleteObject(ofType: DBNewsSource.self) { items in
            return items.filter { $0.sourceUrlString == object.sourceUrlString }.first
        }
    }
    
    func cleareDataBase() {
        dataBaseService.clearDataBase(ofType: DBNewsSource.self)
    }
    
}

extension NewsSourceDtoService {
    func fillDBModel(_ model: NewsSourceDtoProtocol) -> DBNewsSource {
        let dbmodel = DBNewsSource()
        dbmodel.sourceUrlString = model.sourceUrlString
        return dbmodel
    }

    func fillModel(_ object: DBNewsSource) -> NewsSource {
        return NewsSource(
            id: object.id,
            sourceUrlString: object.sourceUrlString
        )
    }
}
