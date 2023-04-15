//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public class StringsCombiner {
    private let separator: String
    private var components: [String] = []

    public init(
        separator: String = " "
    ) {
        self.separator = separator
    }

    public func append(_ component: String?) -> Self {
        guard let component else { return self }
        guard component.count > 0 else { return self }
        components.append(component)
        return self
    }

    public func toString() -> String {
        let output = components.joined(separator: separator)
        return output
    }
}
