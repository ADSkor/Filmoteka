//
//  File.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public class Cache<T: AnyObject> {
    private var cache: NSCache<NSString, T> = .init()

    public init() {}

    public func get(
        _ key: String
    ) -> T? {
        cache.object(forKey: key as NSString)
    }

    public func set(
        _ key: String,
        _ value: T
    ) {
        cache.setObject(value, forKey: key as NSString)
    }
}
