//
//  SettingsViewController.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 08.11.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var output: SettingsViewOutput?

    private lazy var dataSource: UITableViewDiffableDataSource<Int, NewsSourceTableViewCellModel> = {
        UITableViewDiffableDataSource<Int, NewsSourceTableViewCellModel>(tableView: sourceTableView) { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NewsSourceTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? NewsSourceTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: model)
            cell.delegate = self
            return cell
        }
    }()

    private let timePicker: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let startTimerButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("start timer", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()

    private let clearCacheButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.black, for: .normal)
        view.setTitle("clear data", for: .normal)
        return view
    }()

    private let addSourceButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.black, for: .normal)
        view.setTitle("add source", for: .normal)
        return view
    }()

    private let sourceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsSourceTableViewCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayoutSubviews()
        setupButtons()
        output?.viewIsReady()
    }

    private func setupUI() {
        view.backgroundColor = .white
        [
            timePicker,
            startTimerButton,
            clearCacheButton,
            addSourceButton,
            sourceTableView
        ].forEach(view.addSubview)

        timePicker.delegate = self
        timePicker.dataSource = self
    }

    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            startTimerButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 15),
            startTimerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            startTimerButton.heightAnchor.constraint(equalToConstant: 44),

            clearCacheButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 15),
            clearCacheButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            clearCacheButton.heightAnchor.constraint(equalToConstant: 44),

            addSourceButton.topAnchor.constraint(equalTo: clearCacheButton.bottomAnchor, constant: 15),
            addSourceButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            addSourceButton.heightAnchor.constraint(equalToConstant: 44),

            sourceTableView.topAnchor.constraint(equalTo: addSourceButton.bottomAnchor, constant: 15),
            sourceTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            sourceTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            sourceTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    private func setupButtons() {
        startTimerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        clearCacheButton.addTarget(self, action: #selector(clearCacheButtonTapped), for: .touchUpInside)
        addSourceButton.addTarget(self, action: #selector(addSourceButtonTapped), for: .touchUpInside)
    }

    @objc
    private func timerButtonTapped() {
        output?.timeButtonTapped()
    }

    @objc
    private func clearCacheButtonTapped() {
        output?.clearCacheButtonTapped()
    }

    @objc
    private func addSourceButtonTapped() {
        presentAlert()
    }

}

extension SettingsViewController {
    func presentAlert() {
        let alert = UIAlertController(
            title: "Добавление нового источника",
            message: "Введите ссылку на RSS источник",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "RSS источник..."
            textField.textAlignment = .center
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        let okAction = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard
                let text = alert.textFields?.first?.text,
                !text.isEmpty,
                let url = URL(string: text),
                UIApplication.shared.canOpenURL(url)
            else { return }
            self?.output?.didTapAddSource(urlString: text)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {

    func viewTimeInterval(_ interval: TimeInterval) {
        timePicker.selectRow(interval.hours, inComponent: 0, animated: false)
        timePicker.selectRow(interval.minutes, inComponent: 1, animated: false)
        timePicker.selectRow(interval.seconds, inComponent: 2, animated: false)
    }
    
    func updateTimerButton(isWork: Bool) {
        startTimerButton.setTitle(isWork ? "stopTimer" : "startTimer", for: .normal)
    }

    func displayNewsSources(sections: NSDiffableDataSourceSnapshot<Int, NewsSourceTableViewCellModel>) {
        DispatchQueue.main.async {
            self.dataSource.apply(sections)
        }
    }
}

//MARK: UIPickerViewDelegate,UIPickerViewDataSource
extension SettingsViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let component = TimeComponent(rawValue: component) else { return 0 }
        switch component {
        case .hours:
            return 25
        case .minutes, .seconds:
            return 61
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let component = TimeComponent(rawValue: component) else { return nil }
        switch component {
        case .seconds:
            return "\(row) S"
        case .minutes:
            return "\(row) M"
        case .hours:
            return "\(row) H"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let component = TimeComponent(rawValue: component) else { return }
        output?.timeIntervalDidChange(value: row, component: component)
    }
}

//MARK: NewsTableViewCellDelegate
extension SettingsViewController: NewsTableViewCellDelegate {
    func deleteButtonTapped(model: NewsSourceTableViewCellModel) {
        output?.deleteSourceButtonTapped(cellModel: model)
    }
}
