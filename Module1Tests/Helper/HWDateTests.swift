//
//  HWDateTests.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 04. 08..
//

import XCTest

final class HWDateTests: XCTestCase {

    // MARK: - Years

    func testShouldBeValidYear() throws {
        validateValid(year: 1)
        validateValid(year: 1900)
        validateValid(year: 2000)
        validateValid(year: 3000)
    }

    func testShouldBeInvalidYear() throws {
        validateInvalid(year: 0)
    }

    // MARK: - Month

    func testShouldBeValidMonth() throws {
        HWDate.Month.allCases.forEach { validateValid(month: $0.rawValue) }
    }

    func testShouldBeInvalidMonth() throws {
        validateInvalid(month: 0)
        validateInvalid(month: 13)
        validateInvalid(month: 14)
        validateInvalid(month: 20)
        validateInvalid(month: 40)
    }

    // MARK: - Day

    func testShouldBeValidDay() throws {
        let years: [UInt] = [2016, 1700, 1800, 1900, 2000, 2020]
        years.forEach { year in
            HWDate.Month.allCases.forEach {
                validateValid(year: year, month: $0.rawValue, day: 1)
                validateValid(year: year, month: $0.rawValue, day: $0.dayCount(year: year))
            }
        }

        validateValid(year: 2016, month: HWDate.Month.february.rawValue, day: 29)
        validateValid(year: 2017, month: HWDate.Month.february.rawValue, day: 28)
    }

    func testShouldBeInvalidDay() throws {
        validateInvalid(year: 2017, month: HWDate.Month.january.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.january.rawValue, day: 32)

        validateInvalid(year: 2016, month: HWDate.Month.february.rawValue, day: 30)
        validateInvalid(year: 2017, month: HWDate.Month.february.rawValue, day: 29)
        validateInvalid(year: 2017, month: HWDate.Month.february.rawValue, day: 0)

        validateInvalid(year: 2017, month: HWDate.Month.march.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.march.rawValue, day: 32)

        validateInvalid(year: 2017, month: HWDate.Month.april.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.april.rawValue, day: 31)

        validateInvalid(year: 2017, month: HWDate.Month.may.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.may.rawValue, day: 32)

        validateInvalid(year: 2017, month: HWDate.Month.june.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.june.rawValue, day: 31)

        validateInvalid(year: 2017, month: HWDate.Month.july.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.july.rawValue, day: 32)

        validateInvalid(year: 2017, month: HWDate.Month.august.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.august.rawValue, day: 32)

        validateInvalid(year: 2017, month: HWDate.Month.september.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.september.rawValue, day: 31)

        validateInvalid(year: 2017, month: HWDate.Month.october.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.october.rawValue, day: 32)

        validateInvalid(year: 2017, month: HWDate.Month.november.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.november.rawValue, day: 31)

        validateInvalid(year: 2017, month: HWDate.Month.december.rawValue, day: 0)
        validateInvalid(year: 2017, month: HWDate.Month.december.rawValue, day: 32)
    }
}

// MARK: - Year validator

private extension HWDateTests {
    func validateInvalid(year: UInt) {
        XCTAssertThrowsError(try HWDate(year: year, month: 1, day: 1)) { error in
            XCTAssertEqual(error as? HWDateError, .illegalArgumentException)
        }
    }

    func validateValid(year: UInt) {
        XCTAssertNoThrow(try HWDate(year: year, month: 1, day: 1))
    }
}

// MARK: - Month validator

private extension HWDateTests {
    func validateInvalid(month: UInt8) {
        XCTAssertThrowsError(try HWDate(year: 2022, month: month, day: 1)) { error in
            XCTAssertEqual(error as? HWDateError, .illegalArgumentException)
        }
    }

    func validateValid(month: UInt8) {
        XCTAssertNoThrow(try HWDate(year: 2022, month: month, day: 1))
    }
}

// MARK: - Day validator

private extension HWDateTests {
    func validateInvalid(year: UInt, month: UInt8, day: UInt8) {
        XCTAssertThrowsError(try HWDate(year: year, month: month, day: day)) { error in
            XCTAssertEqual(error as? HWDateError, .illegalArgumentException)
        }
    }

    func validateValid(year: UInt, month: UInt8, day: UInt8) {
        XCTAssertNoThrow(try HWDate(year: year, month: month, day: day))
    }
}
