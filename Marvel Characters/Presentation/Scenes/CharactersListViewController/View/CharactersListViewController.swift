//
//  CharactersListViewController.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import UIKit
import Combine
import SkeletonView

class CharactersListViewController: UIViewController {
//MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchFieldContainerView: UIView!
//MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: CharactersListViewModel
//MARK: - Initializer
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.load()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayers()
    }
//MARK: - Functions
    private func setUp() {
        titleLabel.text = "Marvel Characters!"
        searchTextField.placeholder = "Looking for a character?"
        setUpTableView()
        bindViewModel()
    }
    private func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.$state
            .sink { [weak self] state in
                self?.update(state: state)
            }.store(in: &cancellables)
    }
    private func setUpLayers() {
        searchFieldContainerView.layer.cornerRadius = 12
        searchFieldContainerView.layer.masksToBounds = true
        searchFieldContainerView.layer.borderColor = UIColor.border.cgColor
        searchFieldContainerView.layer.borderWidth = 1
    }
    private func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
    private func update(state: TableViewState) {
        switch state {
            case .empty:
                break
            case .error(let string):
                break
            case .loading:
                tableView.showAnimatedGradientSkeleton()
            case .loaded:
                tableView.hideSkeleton()
        }
    }
}

//MARK: - UITableViewDataSource
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError()
        }
        viewModel.setUp(cell: cell, at: indexPath)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}

//MARK: - SkeletonTableViewDataSource
extension CharactersListViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CharacterTableViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
