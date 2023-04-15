//
//  Bag.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public final class Bag {
    private var map: [String: Any] = [:]

    public init() {}

    public func append(_ object: Any) -> String {
        let uuid = UUID().uuidString
        map[uuid] = object
        return uuid
    }

    public func remove(uuid: String) {
        map.removeValue(forKey: uuid)
    }

    public func clean() {
        map.removeAll()
    }
}
