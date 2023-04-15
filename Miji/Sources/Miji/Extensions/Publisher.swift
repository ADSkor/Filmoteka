//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Combine
import Foundation

public extension Publisher where Self.Failure == Never {
    func debounce(
        for _: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(500),
        subscriptions: inout Set<AnyCancellable>,
        action: ((Self.Output) -> Void)?
    ) {
        debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(
                receiveValue: { value in
                    action?(value)
                }
            )
            .store(in: &subscriptions)
    }
}
