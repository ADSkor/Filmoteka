//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public extension URL {
    func asString() -> String? {
        absoluteString
    }

    func pureURL() -> URL? {
        guard var urlcomponents = URLComponents(
            url: self,
            resolvingAgainstBaseURL: false
        ) else {
            return nil
        }
        urlcomponents.query = nil

        return urlcomponents
            .string?
            .asURL()
    }
}
