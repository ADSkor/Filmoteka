//
//  CLPlacemark.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Contacts
import CoreLocation
import Foundation

public extension CLPlacemark {
    func humanReadableAddress() -> String? {
        guard let postalAddress else { return nil }
        return "\(postalAddress.street) \(postalAddress.city) \(postalAddress.country) \(postalAddress.postalCode)"
    }
}
