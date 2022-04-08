//
//  LeapYearCalculator.swift
//  Module1Tests
//
//  Created by Adam Bella on 2022. 04. 08..
//

enum LeapYearCalculator {
   static func isLeapYear(_ year: UInt) -> Bool {
       switch (year.isMultiple(of: 4), year.isMultiple(of: 100), year.isMultiple(of: 400)) {
       case (true, false, false):
           return true
       case (true, true, true):
           return true
       default:
           return false
       }
   }
}
