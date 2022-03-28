//
//  DataListRequestTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class DataListRequestTests: XCTestCase {
    func testDataListRequestSetGetSuccess() throws {
        let parameters = DataListRequest.QueryParameters()
        XCTAssertEqual(parameters.number, 10)
        XCTAssertEqual(parameters.length, 8)
        XCTAssertEqual(parameters.digits, "on")
        XCTAssertEqual(parameters.upperalpha, "on")
        XCTAssertEqual(parameters.loweralpha, "on")
        XCTAssertEqual(parameters.unique, "on")
        XCTAssertEqual(parameters.format, "plain")
        XCTAssertEqual(parameters.random, "new")

        let request = DataListRequest(parameters: parameters)
        XCTAssertEqual(request.path, "/strings")

        let queryItems = request.queryItems
        XCTAssertNotNil(queryItems)
        XCTAssertEqual(queryItems?["num"] as? Int, 10)
        XCTAssertEqual(queryItems?["len"] as? Int, 8)
        XCTAssertEqual(queryItems?["digits"] as? String, "on")
        XCTAssertEqual(queryItems?["upperalpha"] as? String, "on")
        XCTAssertEqual(queryItems?["loweralpha"] as? String, "on")
        XCTAssertEqual(queryItems?["unique"] as? String, "on")
        XCTAssertEqual(queryItems?["format"] as? String, "plain")
        XCTAssertEqual(queryItems?["rnd"] as? String, "new")
    }
}
