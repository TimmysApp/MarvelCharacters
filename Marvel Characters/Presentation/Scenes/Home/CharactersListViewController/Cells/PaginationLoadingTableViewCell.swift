//
//  PaginationLoadingTableViewCell.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import UIKit

class PaginationLoadingTableViewCell: UITableViewCell {
//MARK: - Properties
    let activityIndicator = UIActivityIndicatorView(style: .large)
    static let identifier = "PaginationLoadingTableViewCell"
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)
        setUpConstraints()
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            activityIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
