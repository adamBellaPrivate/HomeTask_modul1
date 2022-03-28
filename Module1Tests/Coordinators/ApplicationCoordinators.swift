//
//  ApplicationCoordinators.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class ApplicationCoordinators: XCTestCase {
    func testNavigation() throws {
        let appcordinator = ApplicationCoordinator(rootViewController: NoAnimationNavigationController())
        XCTAssertEqual(appcordinator.rootViewController.viewControllers.count, 1)
        XCTAssertTrue(appcordinator.rootViewController.visibleViewController is LoginViewController)
        appcordinator.successfullyLoggedIn()
        XCTAssertEqual(appcordinator.rootViewController.viewControllers.count, 1)
        XCTAssertTrue(appcordinator.rootViewController.visibleViewController is DataListViewController)
    }
}

final class NoAnimationNavigationController: UINavigationController {
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: false)
    }
}
