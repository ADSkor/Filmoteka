//
//  Int.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public extension Int {
    func asSeparatedIntoGroupBy(groupCount: Int) -> String {
        let result = NSNumber(value: self)
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = groupCount
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        guard let stringFromNumber = numberFormatter.string(from: result) as String? else { return String(self) }
        return stringFromNumber
    }

    static func TB(_ units: Int) -> Int {
        units * 1024 * 1024 * 1024 * 1024
    }

    static func GB(_ units: Int) -> Int {
        units * 1024 * 1024 * 1024
    }

    static func MB(_ units: Int) -> Int {
        units * 1024 * 1024
    }

    static func KB(_ units: Int) -> Int {
        units * 1024
    }

    static func B(_ units: Int) -> Int {
        units
    }
}
