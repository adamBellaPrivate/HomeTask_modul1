//
//  HWDate.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 04. 08..
//

import Foundation

enum HWDateError: Error {
    case illegalArgumentException
}

extension HWDate {
    enum Month: UInt8, CaseIterable {
        case january = 1
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december

        static let minMonthIndex: UInt8 = Month.january.rawValue
        static let maxMonthIndex: UInt8 = Month.december.rawValue

        func dayCount(year: UInt) -> UInt8 {
            switch self {
            case .january, .march, .may, .july, .august, .october, .december:
                return 31
            case .february where !LeapYearCalculator.isLeapYear(year):
                return 28
            case .february:
                return 29
            case .april, .june, .september, .november:
                return 30
            }
        }
    }
}

struct HWDate {
    let year: UInt
    let month: UInt8
    let day: UInt8

    init(year: UInt, month: UInt8, day: UInt8) throws {
        try Self.validateYear(year: year)
        try Self.validateMonth(month: month)
        try Self.validateDay(year: year, month: month, day: day)

        self.year = year
        self.month = month
        self.day = day
    }
}

private extension HWDate {

    // MARK: - Year validation

    static func validateYear(year: UInt) throws {
        guard year > .zero else {
            throw HWDateError.illegalArgumentException
        }
    }

    // MARK: - Month validation

    static func validateMonth(month: UInt8) throws {
        guard month >= Month.minMonthIndex, month <= Month.maxMonthIndex else {
            throw HWDateError.illegalArgumentException
        }
    }

    // MARK: - Day validation

    static func validateDay(year: UInt, month: UInt8, day: UInt8) throws {
        guard let month = Month(rawValue: month) else { throw HWDateError.illegalArgumentException }

        let count = month.dayCount(year: year)
        guard day >= 1, day <= count else { throw HWDateError.illegalArgumentException }

        /*
         let dateComponents = DateComponents(year: year, month: month)
         let date = Calendar.current.date(from: dateComponents)!

         let range = calendar.range(of: .day, in: .month, for: date)!
         let numDays = range.count
         */
    }
}
