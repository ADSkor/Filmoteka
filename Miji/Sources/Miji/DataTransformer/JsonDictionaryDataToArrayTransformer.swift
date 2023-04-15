//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public class JsonDictionaryDataToArrayTransformer: DataTransformer {
    private let key: String

    public init(
        key: String
    ) {
        self.key = key
    }

    override public func transform(data: Data?) -> Data? {
        guard var jsonDataString = data?.asString() else { return nil }
        _ = jsonDataString.removeFirst()
        _ = jsonDataString.removeLast()
        let items = jsonDataString.split(",")
        let outputItems = items.map { "{\($0)}" }
        let output = outputItems.joined(separator: ",")
        let outputJson = "{\"\(key)\" : [\(output)] }"
        return outputJson.asData()
    }
}
