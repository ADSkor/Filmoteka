//
//  FastLocationResolver.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

public typealias FastLocationResolverCompletion = (CLLocation?) -> Void

public final class FastLocationResolver: NSObject {
    private let locationManager: CLLocationManager = .init()
    private var completion: FastLocationResolverCompletion?
    private var tried = false

    public func resolve(completion: @escaping FastLocationResolverCompletion) {
        self.completion = completion
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension FastLocationResolver: CLLocationManagerDelegate {
    public func locationManager(
        _: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard tried == false else { return }
        guard let userLocation = locations.first else { return }
        tried = true
        completion?(userLocation)
    }

    public func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            completion?(nil)
            return
        }
        let manager = CLLocationManager()
        let authorizationStatus: CLAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch error.code {
        case .denied:
            switch authorizationStatus {
            case .notDetermined:
                return
            default:
                break
            }
        default:
            break
        }

        tried = true
        completion?(nil)
    }
}
