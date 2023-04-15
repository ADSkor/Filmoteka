//
//  RequestsOutput.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public final class RequestOutput<T> {
    public let error: Error?
    public let payload: T?

    init(
        error: Error?,
        payload: T?
    ) {
        self.error = error
        self.payload = payload
    }
}
