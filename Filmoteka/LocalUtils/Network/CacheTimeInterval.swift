//
//  CacheTimeInterval.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation

enum CacheTimeInterval {
    case timeInterval(_: TimeInterval)
    case returnCacheAndMakeRequest
}

typealias CacheOptions = (CacheTimeInterval, String)
