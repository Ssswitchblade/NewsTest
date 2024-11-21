//
//  ViewController.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import UIKit

final class NewsListViewController: UIViewController {
    
    var output: NewsListViewOutput?

    private lazy var dataSource: UITableViewDiffableDataSource<Int, NewsTableViewCellModel> = {
        UITableViewDiffableDataSource<Int, NewsTableViewCellModel>(tableView: tableView) { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: model)
            return cell
        }
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupLayoutSubviews()
        output?.viewIsReady()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.title = "News"
        tableView.register(NewsTableViewCell.self)
        tableView.delegate = self
    }

    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: NewsListViewInput
extension NewsListViewController: NewsListViewInput {    
    func displayNewModels(news: [NewsTableViewCellModel], animated: Bool) {
        DispatchQueue.main.async {
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteAllItems()
            snapshot.appendSections([0])
            snapshot.appendItems(news)
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }

    func displayReload(id: UUID) {
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectNews(at: indexPath.row)
    }
}
