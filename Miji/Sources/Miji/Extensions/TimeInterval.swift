//
//  TimeInterval.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public extension TimeInterval {
    static func Days(_ units: TimeInterval) -> TimeInterval {
        return units * 60 * 60 * 24
    }

    static func Hours(_ units: TimeInterval) -> TimeInterval {
        return units * 60 * 60
    }

    static func Minutes(_ units: TimeInterval) -> TimeInterval {
        return units * 60
    }

    static func Seconds(_ seconds: TimeInterval) -> TimeInterval {
        return seconds // eh?
    }

    func toString() -> String {
        return "\(self)"
    }
}
