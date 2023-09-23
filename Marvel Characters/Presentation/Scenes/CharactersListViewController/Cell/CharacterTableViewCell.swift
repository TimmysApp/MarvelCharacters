//
//  CharacterTableViewCell.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
//MARK: - Properties
    static let identifier = "CharacterTableViewCell"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//MARK: - Functions
    private func setUp() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        setUpConstraints()
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    func setUp(with viewModel: CharacterTableCellViewModel) {
        titleLabel.text = viewModel.title
    }
}
