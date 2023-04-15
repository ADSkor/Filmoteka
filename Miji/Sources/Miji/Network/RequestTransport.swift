//
//  RequestTransport.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

open class RequestTransport<T> {
    public let input: T

    public required init(
        _ input: T
    ) {
        self.input = input
        debugPrint("\(input)")
    }

    open func perform(completion: ((Error?, Any?) -> Void)?) {
        completion?(nil, nil)
    }
}
