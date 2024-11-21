//
//  NewsSourceTableViewCell.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 19.11.2024.
//

import UIKit

protocol NewsTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(model: NewsSourceTableViewCellModel)
}

struct NewsSourceTableViewCellModel: Hashable {
    let id: UUID = UUID()
    let title: String
}

final class NewsSourceTableViewCell: UITableViewCell {

    private var model: NewsSourceTableViewCellModel?

    weak var delegate: NewsTableViewCellDelegate?

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let deleteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("delete", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with model: NewsSourceTableViewCellModel) {
        self.model = model
        titleLabel.text = model.title
    }

    @objc
    private func deleteButtonTapped() {
        guard let model else { return }
        delegate?.deleteButtonTapped(model: model)
    }

    private func setupUI() {
        [
            titleLabel,
            deleteButton
        ].forEach(contentView.addSubview)
        selectionStyle = .none
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    private func makeLayoutSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),

            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            deleteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
