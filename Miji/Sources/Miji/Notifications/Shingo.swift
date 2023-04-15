//
//  Shingo.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

// 信号 - means signal

public class Shingo<T> {
    let payloadClass: T.Type

    public init(_ payloadClass: T.Type) {
        self.payloadClass = payloadClass
    }

    private func send(
        _ name: String,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        // swiftlint:disable:next notification_call
        NotificationCenter.default.post(
            Notification(
                name: Notification.Name(rawValue: name),
                userInfo: userInfo
            )
        )
    }

    public func send(
        name: String,
        payload: T
    ) {
        send(
            name,
            userInfo: ["payload": payload]
        )
    }

    public func receive(
        name: String,
        bag: Bag,
        completion: ((T) -> Void)?
    ) {
        let observer = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(
                rawValue: name
            ),
            object: nil,
            queue: nil
        ) { notificaton in
            guard let payload = notificaton.userInfo?["payload"] as? T else { return }
            completion?(payload)
        }
        _ = bag.append(observer)
    }
}
