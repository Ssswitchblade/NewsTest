//
//  NewsRepository.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 12.11.2024.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    var newsObsevable: PassthroughSubject<[NewsDTOProtocol], Error> { get }
    func getNews() -> [NewsDTOProtocol]
    func updateNews(model: NewsDTOProtocol)
    func updateTimerInterval(time: Double)
    func startTimer()
    func stopTImer()
    func getTimeInterval() -> TimeInterval
    func clearCache()
    func getNewsSources() -> [NewsSourceDtoProtocol]
    func deleteNewsSource(_ model: NewsSourceDtoProtocol)
    func saveNewsSource(_ model: NewsSourceDtoProtocol)
}

final class NewsRepository: NewsRepositoryProtocol {

    private let newsRestService: NewsRestServiceProtocol
    private let newsStorage: NewsStoragesProcol
    private let newsSourceStorage: NewsSourceStoragesProtocol
    private var newsDidGet: [NewsModel] = []

    var newsObsevable: PassthroughSubject<[NewsDTOProtocol], Error> = PassthroughSubject<[NewsDTOProtocol], Error>()

    private var timer: Timer?

    private var timeInterval: Double {
        get {
            UserDefaults.standard.object(forKey: "TimerInterval") as? Double ?? 10.0
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TimerInterval")
        }
    }

    init(
        newsRestService: NewsRestServiceProtocol,
        newsStorage: NewsStoragesProcol,
        newsSourceStorage: NewsSourceStoragesProtocol
    ) {
        self.newsRestService = newsRestService
        self.newsStorage = newsStorage
        self.newsSourceStorage = newsSourceStorage
    }

    private func setupTimer(interval: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self else { return }
            let sources = self.getNewsSources()
            self.newsRestService.getNewsFromRSS(sources: sources) { result in
                switch result {
                case .success(let models):
                    self.didGetRestNews(models)
                case .failure(let error):
                    self.newsObsevable.send(completion: .failure(error))
                }
            }
        }
    }

    func getNews() -> [NewsDTOProtocol] {
        let allNewsFromDb = newsStorage.getAll()
        newsDidGet.append(contentsOf: allNewsFromDb.map { NewsModel(model: $0)})
        return allNewsFromDb
    }

    func saveNews(_ models: [NewsDTOProtocol]) {
        newsStorage.save(objects: models)
    }

    func updateNews(model: NewsDTOProtocol) {
        newsStorage.save(object: model)
    }

    func updateTimerInterval(time: Double) {
        timeInterval = time
        setupTimer(interval: time)
    }

    func stopTImer() {
        timer?.invalidate()
        timer = nil
    }

    func startTimer() {
        setupTimer(interval: timeInterval)
    }

    func getTimeInterval() -> TimeInterval {
        TimeInterval(totalSeconds: timeInterval)
    }

    func clearCache() {
        newsStorage.cleareDataBase()
//        newsSourceStorage.cleareDataBase()
    }

    func getNewsSources() -> [NewsSourceDtoProtocol] {
        newsSourceStorage.getAll()
    }
    
    func deleteNewsSource(_ model: NewsSourceDtoProtocol) {
        newsSourceStorage.delete(object: model)
    }

    func saveNewsSource(_ model: NewsSourceDtoProtocol) {
        newsSourceStorage.save(object: model)
    }

}

extension NewsRepository {
    func didGetRestNews(_ restModels: [any NewsDTOProtocol]) {
        guard restModels.count != 0 else { return }
        let newsModels = restModels.map { NewsModel(model: $0) }
        var unigueNews = Set(newsModels)
        unigueNews = unigueNews.filter { !newsDidGet.contains($0) }
        guard unigueNews.count != 0 else { return }
        newsDidGet.append(contentsOf: unigueNews)
        self.newsObsevable.send(Array(unigueNews))
        self.newsStorage.save(objects: Array(unigueNews))
    }
}
