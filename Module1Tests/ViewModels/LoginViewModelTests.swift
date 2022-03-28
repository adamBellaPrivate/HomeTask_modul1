//
//  LoginViewModelTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class LoginViewModelTests: XCTestCase {
    func testSuccessLogin() throws {
        let view = MockLoginViewInterface()
        let coordinator = MockLoginViewFlowDelegate()
        let viewModel = LoginViewModel(view: view, flowDelegate: coordinator)
        viewModel.login(username: "user", password: "123qwe")
        XCTAssertNil(view.errorMessage)
        XCTAssertEqual(coordinator.isSuccess, true)
    }

    func testLoginWithIncorrectUsername() throws {
        let view = MockLoginViewInterface()
        let coordinator = MockLoginViewFlowDelegate()
        let viewModel = LoginViewModel(view: view, flowDelegate: coordinator)
        viewModel.login(username: "user2", password: "123qwe")
        XCTAssertNotNil(view.errorMessage)
        XCTAssertEqual(view.errorMessage, "Invalid credentials")
        XCTAssertEqual(coordinator.isSuccess, false)
    }

    func testLoginWithIncorrectPassword() throws {
        let view = MockLoginViewInterface()
        let coordinator = MockLoginViewFlowDelegate()
        let viewModel = LoginViewModel(view: view, flowDelegate: coordinator)
        viewModel.login(username: "user", password: "123qwe2")
        XCTAssertNotNil(view.errorMessage)
        XCTAssertEqual(view.errorMessage, "Invalid credentials")
        XCTAssertEqual(coordinator.isSuccess, false)
    }

    func testLoginWithIncorrectData() throws {
        let view = MockLoginViewInterface()
        let coordinator = MockLoginViewFlowDelegate()
        let viewModel = LoginViewModel(view: view, flowDelegate: coordinator)
        viewModel.login(username: nil, password: nil)
        XCTAssertNotNil(view.errorMessage)
        XCTAssertEqual(view.errorMessage, "Invalid credentials")
        XCTAssertEqual(coordinator.isSuccess, false)
    }
}

final class MockLoginViewInterface: LoginViewInterface {
    private(set) var errorMessage: String?

    func present(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

final class MockLoginViewFlowDelegate: LoginFlowDelegate {
    private(set) var isSuccess = false

    func successfullyLoggedIn() {
        isSuccess = true
    }
}
