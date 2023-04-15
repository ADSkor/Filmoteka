//
//  Array+OptionalAccess.swift
//  For Any App
//
//  Created by Ilia Prokhorov on 02.03.2022.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import AVFoundation
import Foundation

public extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }

    func at(_ index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }

    func at<T>(_ index: Int, _ byDefault: T) -> T {
        let element = at(index) as? T
        return element ?? byDefault
    }

    mutating func safeRemoveAt(_ index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return remove(at: index)
    }

    mutating func popFirst() -> Element? {
        return safeRemoveAt(0)
    }

    mutating func clear() {
        removeAll()
    }

    func center() -> Element? {
        return at(count / 2)
    }

    func exists(where predicate: (Element) -> Bool) -> Bool {
        contains(where: predicate) == true
    }

    mutating func remove(where predicate: (Element) -> Bool) {
        while let index = firstIndex(where: predicate) {
            remove(at: index)
        }
    }

    mutating func replace(where predicate: (Element) -> Bool, _ element: Element) {
        while let index = firstIndex(where: predicate) {
            self[index] = element
        }
    }
}

extension Array where Element: Equatable {
    mutating func replace(_ lhs: Element, _ rhs: Element) {
        guard let index = firstIndex(where: { $0 == lhs }) else { return }
        self[index] = rhs
    }
}

public extension Array where Element: Hashable {
    func isLast(_ element: Element) -> Bool {
        let result = element == last
        return result
    }

    func isNotLast(_ element: Element) -> Bool {
        return !isLast(element)
    }

    func removingHashableDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func replace(_ originalItem: Element, _ item: Element) {
        guard let index = index(ofItem: originalItem) else { return }
        _ = safeRemoveAt(index)
        insert(item, at: index)
    }

    mutating func remove(_ item: Element) {
        guard let index = index(ofItem: item) else { return }
        _ = safeRemoveAt(index)
    }

    mutating func removingHashableDuplicates() {
        self = removingHashableDuplicates()
    }

    func index(ofItem item: Element) -> Int? {
        firstIndex { $0 == item }
    }
}

public extension Array where Element == URLQueryItem {
    func value(name: String) -> String? {
        return first { $0.name == name }?.value
    }
}

public extension Array where Element == UInt8 {
    func asData() -> Data {
        return Data(self)
    }
}
