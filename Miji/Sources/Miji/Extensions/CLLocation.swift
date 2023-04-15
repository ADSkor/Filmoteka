//
//  File.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocation {
    var latitude: CLLocationDegrees { coordinate.latitude }
    var longitude: CLLocationDegrees { coordinate.longitude }
}
