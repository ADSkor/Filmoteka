//
//  HTTPQuery.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public typealias HTTPQuery = [String: CustomStringConvertible]

public extension HTTPQuery {
    func asQueryString() throws -> String {
        let output = try map { key, value in
            if let dictionary = value as? Dictionary {
                let items: [String] = dictionary.compactMap { itemKey, itemValue in
                    let itemOutput = "\(key)[\(itemKey)]=\(itemValue)"
                    guard let itemOutputEscaped = itemOutput.htmlEscaped() else { return nil }
                    return itemOutputEscaped
                }

                debugPrint(items)
                debugPrint("---")

                let dictionaryOutput = items.joined(separator: "&")

                return dictionaryOutput
            }
            else {
                guard let key = key.htmlEscaped() else {
                    throw NSError.error(localizedDescription: "key \(key) cannot be htmlEscaped")
                }
                guard let value = value.description.htmlEscaped() else {
                    throw NSError.error(localizedDescription: "value \(value) cannot be htmlEscaped")
                }
                return "\(key)=\(value)"
            }
        }.joined(separator: "&")
        return output
    }
}
