//
//  CLAuthorizationStatus.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import CoreLocation

public extension CLAuthorizationStatus {
    func asString() -> String {
        switch self {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .authorized:
            return "authorized"
        @unknown default:
            return "Unknown status - CLAuthorizationStatus (\(rawValue))"
        }
    }
}
