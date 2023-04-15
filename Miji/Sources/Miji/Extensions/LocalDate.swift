//
//  LocalDate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public final class LocalDate {
    let unixDate: Date
    let timeZone: TimeZone

    public init(
        unixDate: Date,
        timeZone: TimeZone
    ) {
        self.unixDate = unixDate
        self.timeZone = timeZone
    }

    public init?(string: String) {
        guard string.count > 6 else { return nil }
        let rawTimeZone = String(string.suffix(6))
        let rawTimeZoneName = "GMT\(rawTimeZone)"
        guard let timeZone = NSTimeZone(name: rawTimeZoneName) as TimeZone? else { return nil }
        self.timeZone = timeZone
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZZZZZZ"
        guard let unixDate = dateFormatter.date(from: string) else { return nil }
        self.unixDate = unixDate
    }

    public func to(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: unixDate)
    }

    public var timeHHmm: String {
        to(format: "HH:mm")
    }
}
