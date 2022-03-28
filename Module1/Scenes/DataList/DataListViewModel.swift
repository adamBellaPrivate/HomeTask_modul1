//
//  DataListViewModel.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import UIKit

protocol DataListViewModelInterface {
    var view: DataListViewInterface? { get }
    var networkService: NetworkProviding { get }

    func fetchData() async
}

final class DataListViewModel: DataListViewModelInterface {
    private(set) weak var view: DataListViewInterface?
    let networkService: NetworkProviding

    init(view: DataListViewInterface, networkService: NetworkProviding) {
        self.view = view
        self.networkService = networkService
    }

    final func fetchData() async {
        view?.showLoading()
        let response = await networkService.request(DataListRequest(parameters: DataListRequest.QueryParameters()))
        view?.hideLoading()
        switch response {
        case .failure:
            self.view?.present(errorMessage: "Communication error!")
        case .success(let data):
            guard let elements = String(data: data, encoding: .utf8)?.split(separator: "\n").compactMap({ String($0) }),
                  !elements.isEmpty else {
                      self.view?.present(errorMessage: "No element!")
                return
            }
            self.view?.present(data: Array(elements))
        }
    }
}
