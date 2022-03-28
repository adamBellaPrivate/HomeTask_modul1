//
//  DataListViewController.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import UIKit

protocol DataListViewInterface: AnyObject {
    func present(data: [String])
    func present(errorMessage: String)
    func showLoading()
    func hideLoading()
}

final class DataListViewController: UIViewController {
    private enum Constants {
        static let cellIdentifier = "Cell"
    }

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Public properties

    var viewModel: DataListViewModel?

    // MARK: - Private properties

    private var elements = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUICompontents()
        Task {
            await viewModel?.fetchData()
        }
    }
}

// MARK: - UITableViewDataSource

extension DataListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = elements[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DataListViewController: UITableViewDelegate {}

// MARK: - DataListViewInterface

extension DataListViewController: DataListViewInterface {
    func present(data: [String]) {
        DispatchQueue.main.async {
            self.elements = data
        }
    }

    func present(errorMessage: String) {
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true, completion: nil)
        }
    }

    func showLoading() {
        if !loadingIndicator.isAnimating {
            loadingIndicator.startAnimating()
        }
        loadingIndicator.isHidden = false
    }

    func hideLoading() {
        if loadingIndicator.isAnimating {
            loadingIndicator.stopAnimating()
        }
        loadingIndicator.isHidden = true
    }
}

private extension DataListViewController {
    func setupUICompontents() {
        setupTableView()
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
}
