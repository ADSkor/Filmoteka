//
//  HTTPRequestInput.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public protocol HTTPRequestInput {
    func endpoint() -> String
    func type() -> HTTPRequestType
    func headers() -> HTTPHeaders
    func query() -> HTTPQuery
    func body() -> HTTPBody
    func isDirectAddress() -> Bool
}

public extension HTTPRequestInput {
    func headers() -> HTTPHeaders {
        return [:]
    }

    func query() -> HTTPQuery {
        return [:]
    }

    func body() -> HTTPBody {
        return [:]
    }

    func isDirectAddress() -> Bool {
        return false
    }
}
