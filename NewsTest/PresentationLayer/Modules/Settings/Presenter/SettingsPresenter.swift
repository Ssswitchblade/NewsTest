//
//  SettingsPresenter.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import UIKit

final class SettingsPresenter {

    var router: SettingsRouterInput?
    weak var view: SettingsViewInput?
    var interactor: SettingsInteractorInput?

    private var timeInterval: TimeInterval?
    private var timerIsWork: Bool = false
    private var presentedNewsSources: [NewsSource] = []
}

//MARK: SettingsViewOutput
extension SettingsPresenter: SettingsViewOutput {

    func viewIsReady() {
        interactor?.viewIsRady()
    }
    
    func timeIntervalDidChange(value: Int, component: TimeComponent) {
        switch component {
        case .seconds:
            timeInterval?.seconds = value
        case .minutes:
            timeInterval?.minutes = value
        case .hours:
            timeInterval?.hours = value
        }
        guard let timeInterval else { return }
        interactor?.timeIntervalDidChange(value: timeInterval.toTotalSeconds())
    }

    func timeButtonTapped() {
        timerIsWork = !timerIsWork
        interactor?.timerUpdated(isWork: timerIsWork)
        view?.updateTimerButton(isWork: timerIsWork)
    }
    
    func clearCacheButtonTapped() {
        interactor?.clearCache()
    }

    func deleteSourceButtonTapped(cellModel: NewsSourceTableViewCellModel) {
        guard let index = presentedNewsSources.firstIndex(where: { $0.sourceUrlString == cellModel.title }) else { return }
        let removedModel = presentedNewsSources.remove(at: index)
        interactor?.deleteNewsSource(removedModel)
        presentNewsSourcesSnapshot()
    }

    func didTapAddSource(urlString: String) {
        let model = NewsSource(id: UUID().uuidString, sourceUrlString: urlString)
        interactor?.addNewsSource(model)
        presentedNewsSources.append(model)
        presentNewsSourcesSnapshot()
    }


}

//MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {
    
    func presentTimeInterval(_ interval: TimeInterval) {
        timeInterval = interval
        view?.viewTimeInterval(interval)
    }

    func presentNewsSourcesInitial(_ models: [NewsSourceDtoProtocol]) {
        presentedNewsSources.append(contentsOf: models.map { NewsSource(model: $0)})
        presentNewsSourcesSnapshot()
    }
}

extension SettingsPresenter {
    func presentNewsSourcesSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsSourceTableViewCellModel>()
        snapshot.appendSections([0])
        let cellModels = presentedNewsSources.map { NewsSourceTableViewCellModel(title: $0.sourceUrlString)}
        snapshot.appendItems(cellModels)
        view?.displayNewsSources(sections: snapshot)
    }
}
