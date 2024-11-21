//
//  NewsViewController.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 18.11.2024.
//

import UIKit

final class NewsViewController: UIViewController {

    var output: NewsViewOutput?

    private let scrollView: UIScrollView = UIScrollView()
    private let newsImageView: BaseUIImageView = BaseUIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let sourceLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let stackView = UIStackView()
    private let scrollContentView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewIsReady()
    }

}

//MARK: NewsViewInput
extension NewsViewController: NewsViewInput {
    func display(news: NewsModel) {
        if let imageURLString = news.imageURL {
            newsImageView.loadImage(from: imageURLString)
        }
        titleLabel.text = news.title
        descriptionLabel.text = "Описание: " + news.descriptionNews
        sourceLabel.text = "Источник: " + news.source
        dateLabel.text = "Дата публикации: " + news.pubDate
        scrollView.layoutIfNeeded()
    }
}

extension NewsViewController {
    func setupUI() {
        view.backgroundColor = .white
        setupScrollView()
        setupNewsImageView()
        setupLabels()
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)

        NSLayoutConstraint.activate([
            // Привязка UIScrollView к краям Safe Area
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // Привязка scrollContentView к UIScrollView
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            // Установка ширины scrollContentView равной UIScrollView
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupNewsImageView() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.contentMode = .scaleAspectFit
        scrollContentView.addSubview(newsImageView)

        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 25),
            newsImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 25),
            newsImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -25),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor)
        ])
    }

    private func setupLabels() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        [titleLabel, descriptionLabel, sourceLabel, dateLabel].forEach { label in
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            stackView.addArrangedSubview(label)
        }

        scrollContentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -15) // Привязка к нижней границе scrollContentView
        ])
    }
}
