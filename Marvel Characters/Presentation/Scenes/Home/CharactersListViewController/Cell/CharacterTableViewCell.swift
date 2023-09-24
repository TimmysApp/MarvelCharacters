//
//  CharacterTableViewCell.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import UIKit
import SkeletonView

class CharacterTableViewCell: UITableViewCell {
//MARK: - Properties
    var indexPath: IndexPath?
    weak var delegate: CharacterTableViewCellDelegate?
    static let identifier = "CharacterTableViewCell"
//MARK: - Views
    private lazy var titlesContainerView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.backgroundColor = .cellBackground.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .text
        label.numberOfLines = 1
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.numberOfLines = 3
        return label
    }()
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isSkeletonable = true
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isSkeletonable = true
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var characterImageView: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayer()
    }
//MARK: - Functions
    private func setUp() {
        isSkeletonable = true
        contentView.isSkeletonable = true
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setUpView()
        setUpConstraints()
    }
    private func setUpView() {
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(descriptionLabel)
        
        containerStackView.addArrangedSubview(characterImageView)
        containerStackView.addArrangedSubview(titlesContainerView)
        
        titlesContainerView.addSubview(titlesStackView)
        
        containerView.addSubview(containerStackView)
        contentView.addSubview(containerView)
    }
    private func setUpLayer() {
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.border.cgColor
        containerView.layer.borderWidth = 1
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.masksToBounds = true
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            containerStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            characterImageView.widthAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 1),
            
            titlesStackView.topAnchor.constraint(greaterThanOrEqualTo: titlesContainerView.topAnchor),
            titlesStackView.leadingAnchor.constraint(equalTo: titlesContainerView.leadingAnchor),
            titlesStackView.centerYAnchor.constraint(equalTo: titlesContainerView.centerYAnchor),
            titlesStackView.centerXAnchor.constraint(equalTo: titlesContainerView.centerXAnchor),
        ])
    }
    func setUp(with viewModel: CharacterTableCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        characterImageView.loader = viewModel.loader
        characterImageView.url = viewModel.imageURL
    }
}
