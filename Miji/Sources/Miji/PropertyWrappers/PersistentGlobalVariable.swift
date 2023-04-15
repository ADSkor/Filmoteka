//
//  PersistentGlobalVariable.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

@propertyWrapper
public struct PersistentGlobalVariable<T> {
    private let key: String
    private let defaultValue: T

    public init(
        _ key: String,
        _ defaultValue: T
    ) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public func RemovePersistentGlobalValue(_ key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}
