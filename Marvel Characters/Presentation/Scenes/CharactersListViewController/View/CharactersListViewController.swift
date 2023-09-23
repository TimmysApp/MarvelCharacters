//
//  CharactersListViewController.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import UIKit

class CharactersListViewController: UIViewController {
//MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
//MARK: - Properties
    var viewModel: CharactersListViewModel
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
        setUpSearchTextField()
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
    }
    private func setUpSearchTextField() {
        searchTextField.layer.cornerRadius = 12
    }
    private func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
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
