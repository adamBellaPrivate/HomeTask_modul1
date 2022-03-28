//
//  LoginDataTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class LoginDataTests: XCTestCase {
    func testLoginDataSetGetSuccess() throws {
        let data = LoginData(username: "user", password: "password")
        XCTAssertNotNil(data)
        XCTAssertEqual(data?.username, "user")
        XCTAssertEqual(data?.password, "password")
    }

    func testLoginDataInitWithUsername() throws {
        let data = LoginData(username: "user", password: nil)
        XCTAssertNil(data)
    }

    func testLoginDataInitWithPassword() throws {
        let data = LoginData(username: nil, password: "password")
        XCTAssertNil(data)
    }

    func testLoginDataInitWithoutData() throws {
        let data = LoginData(username: nil, password: nil)
        XCTAssertNil(data)
    }

    func testLoginDataInitWithEmptyUsername() throws {
        let data = LoginData(username: "", password: nil)
        XCTAssertNil(data)
    }

    func testLoginDataInitWitEmptyhPassword() throws {
        let data = LoginData(username: nil, password: "")
        XCTAssertNil(data)
    }

    func testLoginDataInitWithEmptyData() throws {
        let data = LoginData(username: "", password: "")
        XCTAssertNil(data)
    }
}
