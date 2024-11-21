//
//  DataBaseService.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 13.11.2024.
//

import Foundation
import RealmSwift

protocol DataBaseServiceProtocol {
    func save<T: Object>(object: T, ofType: T.Type)
    func save<T: Object>(objects: [T], ofType: T.Type)
    func getAll<Item: Object, Model>(ofType: Item.Type, completion: @escaping ([Item]) -> [Model]) -> [Model]
    func deleteObject<Item: Object>(ofType: Item.Type, filter: ([Item]) -> Item?)
    func clearDataBase<Item: Object>(ofType: Item.Type)
}

final class DataBaseService: DataBaseServiceProtocol {
    
    private lazy var dataBase: Realm? = {
        do {
             return try Realm(configuration: .defaultConfiguration, queue: queue)
        } catch {
            print("Error initializing Realm: \(error)")
            return nil
        }
    }()
    
    private let queue = DispatchQueue(label: "com.newstest.realm.queue")
    
    func save<T: Object>(object: T, ofType: T.Type) {
        save(objects: [object], ofType: ofType)
    }
    
    func save<T: Object>(objects: [T], ofType: T.Type) {
        queue.sync {
            do {
                try dataBase?.write {
                    dataBase?.add(objects, update: .modified)
                }
            } catch {
                assertionFailure("Failed to write to the database: \(error)")
            }
        }
    }
    
    func getAll<Item: Object, Model>(ofType: Item.Type, completion: @escaping ([Item]) -> [Model]) -> [Model] {
        queue.sync {
            guard let items = dataBase?.objects(Item.self) else {
                return [] }
            let arrayItems: [Item] = Array(items)
            return completion(arrayItems)
        }
    }

    func deleteObject<Item: Object>(ofType: Item.Type, filter: ([Item]) -> Item?) {
        queue.sync {
            guard let items = dataBase?.objects(Item.self) else { return }
            let arrayItems: [Item] = Array(items)
            guard let item = filter(arrayItems) else { return }
            do {
                try dataBase?.write {
                    dataBase?.delete(item)
                }
            } catch {
                assertionFailure("Failed to delete object in the database: \(error)")
            }
                    
        }
    }
    
    func clearDataBase<Item: Object>(ofType: Item.Type) {
        queue.sync {
            guard let items = dataBase?.objects(Item.self) else { return  }
            do {
                try dataBase?.write {
                    dataBase?.delete(items)
                }
            } catch {
                assertionFailure("Failed to delete all objects in the database: \(error)")
            }
        }
    }
}
