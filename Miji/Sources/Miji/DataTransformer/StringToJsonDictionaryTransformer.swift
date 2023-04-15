//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public class StringToJsonDictionaryTransformer: DataTransformer {
    private let key: String

    public init(
        key: String
    ) {
        self.key = key
    }

    override public func transform(data: Data?) -> Data? {
        guard let jsonDataString = data?.asString() else { return nil }
        let outputJson = "{ \"\(key)\" : \(jsonDataString) }"
        return outputJson.asData()
    }
}
