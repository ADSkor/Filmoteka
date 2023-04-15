//
//  MulticastDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public class MulticastDelegate<T> {
    private let delegates = NSHashTable<AnyObject>.weakObjects()

    public init() {}

    public func subscribe(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }

    public func unsubscribe(_ delegate: T) {
        delegates.remove(delegate as AnyObject)
    }

    public func notify(_ invocation: (T) -> Void) {
        for delegate in delegates.allObjects {
            if let delegate = delegate as? T {
                invocation(delegate)
            }
        }
    }
}
