//
//  ApplicationCoordinator.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import UIKit

final class ApplicationCoordinator {
    let rootViewController: UINavigationController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        setLoginToRootController()
    }
}

extension ApplicationCoordinator: LoginFlowDelegate {
    func successfullyLoggedIn() {
        setDataListToController()
    }
}

private extension ApplicationCoordinator {
    func setLoginToRootController() {
        let loginVC = LoginViewController()
        let viewModel = LoginViewModel(view: loginVC, flowDelegate: self)
        loginVC.viewModel = viewModel
        rootViewController.setViewControllers([loginVC], animated: true)
    }

    func setDataListToController() {
        let dataListVC = DataListViewController()
        let viewModel = DataListViewModel(view: dataListVC, networkService: NetworkProvider())
        dataListVC.viewModel = viewModel
        rootViewController.setViewControllers([dataListVC], animated: true)
    }
}
