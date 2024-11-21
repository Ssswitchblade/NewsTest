//
//  SettingsInteractor.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import Foundation

final class SettingsInteractor {
    
    weak var output: SettingsInteractorOutput?
    
    private let newsRepository: NewsRepositoryProtocol
    
    init( newsRepository: NewsRepositoryProtocol) {
        self.newsRepository = newsRepository
    }
}

//MARK: SettingsInteractorInput
extension SettingsInteractor: SettingsInteractorInput {
    
    func viewIsRady() {
        output?.presentTimeInterval(newsRepository.getTimeInterval())
        output?.presentNewsSourcesInitial(newsRepository.getNewsSources())
    }
    
    func timeIntervalDidChange(value: Double) {
        newsRepository.updateTimerInterval(time: value)
    }
    
    func timerUpdated(isWork: Bool) {
        switch isWork {
        case true:
            newsRepository.startTimer()
        case false:
            newsRepository.stopTImer()
        }
    }

    func clearCache() {
        newsRepository.clearCache()
    }

    func deleteNewsSource(_ model: NewsSourceDtoProtocol) {
        newsRepository.deleteNewsSource(model)
    }

    func addNewsSource(_ model: NewsSourceDtoProtocol) {
        newsRepository.saveNewsSource(model)
    }
}

extension SettingsInteractor {
    
}
