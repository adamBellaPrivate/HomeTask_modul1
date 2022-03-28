//
//  NetworkProviderTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 02. 27..
//

import XCTest
@testable import Module1

final class NetworkProviderTests: XCTestCase {
    func testURLBuilder() throws {
        let networkProvider = NetworkProvider()

        let parameters = DataListRequest.QueryParameters()
        let request = DataListRequest(parameters: parameters)

        let url = networkProvider.buildURL(request)
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "www.random.org")
        XCTAssertEqual(url?.path, "/strings")

        let urlComponents = URLComponents(string: url!.absoluteString)
        var queryStrings = [String: String]()
        urlComponents?.queryItems?.forEach { item in
            queryStrings[item.name] = item.value ?? ""
        }

        XCTAssertEqual(queryStrings.count, 8)
        XCTAssertEqual(queryStrings["num"], "10")
        XCTAssertEqual(queryStrings["len"], "8")
        XCTAssertEqual(queryStrings["digits"], "on")
        XCTAssertEqual(queryStrings["upperalpha"], "on")
        XCTAssertEqual(queryStrings["loweralpha"], "on")
        XCTAssertEqual(queryStrings["unique"], "on")
        XCTAssertEqual(queryStrings["format"], "plain")
        XCTAssertEqual(queryStrings["rnd"], "new")
    }
}
