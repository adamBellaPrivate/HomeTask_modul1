//
//  LeapYearCalculatorTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 04. 08..
//

import XCTest

final class LeapYearCalculatorTests: XCTestCase {
    func testShouldBeLeapYear() throws {
        [2016, 2000, 2020].forEach {
            XCTAssertTrue(LeapYearCalculator.isLeapYear($0))
        }
    }

    func testShouldNotBeLeapYear() throws {
        [1700, 1800, 1900, 2019, 2100, 2200, 2300].forEach {
            XCTAssertFalse(LeapYearCalculator.isLeapYear($0))
        }
    }
}
