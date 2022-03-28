//
//  DataListViewModelTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class DataListViewModelTests: XCTestCase {
    func testSuccessMoreResults() async throws {
        let view = MockDataListViewInterface()
        let strings = ["abcd", "dcba"]
        let networkProvider = MockNetworkProvider(behaviour: .success(strings: strings.joined(separator: "\n")))
        let viewModel = DataListViewModel(view: view, networkService: networkProvider)
        let expectation = expectation(description: "FetchDataExpectation")
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 3)
        XCTAssertNil(view.errorMessage)
        XCTAssertEqual(view.strings.count, 2)
        XCTAssertEqual(view.strings, strings)
    }

    func testSuccessEmptyResults() async throws {
        let view = MockDataListViewInterface()
        let networkProvider = MockNetworkProvider(behaviour: .success(strings: ""))
        let viewModel = DataListViewModel(view: view, networkService: networkProvider)
        let expectation = expectation(description: "FetchDataExpectation")
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 3)
        XCTAssertNotNil(view.errorMessage)
        XCTAssertEqual(view.errorMessage, "No element!")
        XCTAssertTrue(view.strings.isEmpty)
    }

    func testFailure() async throws {
        let view = MockDataListViewInterface()
        let networkProvider = MockNetworkProvider(behaviour: .failure)
        let viewModel = DataListViewModel(view: view, networkService: networkProvider)
        let expectation = expectation(description: "FetchDataExpectation")
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 3)
        XCTAssertNotNil(view.errorMessage)
        XCTAssertEqual(view.errorMessage, "Communication error!")
        XCTAssertTrue(view.strings.isEmpty)
    }
}

final class MockDataListViewInterface: DataListViewInterface {
    private(set) var strings = [String]()
    private(set) var errorMessage: String?

    func present(data: [String]) {
        strings = data
    }

    func present(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    func showLoading() {}
    func hideLoading() {}
}

final class MockNetworkProvider: NetworkProviding {
    enum Behaviour {
        case success(strings: String)
        case failure
    }

    private let behaviour: Behaviour

    init(behaviour: Behaviour) {
        self.behaviour = behaviour
    }

    func request(_ request: ApiRequest) async -> Result<Data, Error> {
        switch behaviour {
        case .success(let strings):
            return .success(strings.data(using: .utf8)!)
        case .failure:
            return .failure(NSError())
        }
    }
}
