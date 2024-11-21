//
//  NewsTableViewCell.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 12.11.2024.
//

import UIKit



struct NewsTableViewCellModel: Hashable {
    let id: UUID
    var title: String
    let imageURL: String?
    var isRead: Bool

    static func == (lhs: NewsTableViewCellModel, rhs: NewsTableViewCellModel) -> Bool {
        return lhs.id == rhs.id && lhs.isRead == rhs.isRead
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class NewsTableViewCell: UITableViewCell {

    private var model: NewsTableViewCellModel?

    private let newsImageView: BaseUIImageView = {
        let imageView = BaseUIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let isReadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.contentMode = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with model: NewsTableViewCellModel) {
        self.model = model
        titleLabel.text = model.title
        isReadLabel.text = model.isRead ? "Прочитано" : "новое"
        guard let imageUrlString = model.imageURL else { return }
        newsImageView.loadImage(from: imageUrlString, placeholder: UIImage(systemName: "photo"))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
    }

    private func setupUI() {
        contentView.backgroundColor = .white
        
        [
            newsImageView,
            titleLabel,
            isReadLabel
        ].forEach(contentView.addSubview)
    }

    private func makeLayoutSubviews() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: isReadLabel.leadingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            isReadLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            isReadLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isReadLabel.widthAnchor.constraint(equalToConstant: 65)
        ])
    }

}
