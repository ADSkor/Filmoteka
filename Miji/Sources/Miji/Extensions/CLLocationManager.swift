//
//  CLLocationManager.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import CoreLocation

public extension CLLocationManager {
    var authorizationStatusString: String {
        if #available(iOS 14.0, *) {
            return authorizationStatus.asString()
        }
        else {
            return CLLocationManager.authorizationStatus().asString()
        }
    }
}
