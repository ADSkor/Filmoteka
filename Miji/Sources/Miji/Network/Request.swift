//
//  Request.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public final class Request<T, U: SerializedData> {
    private let input: T
    public let transport: RequestTransport<T>

    private var uuid = ""

    public init(
        _ input: T,
        _ transport: RequestTransport<T>
    ) {
        self.input = input
        self.transport = transport
    }

    public func perform(
        _ bag: Bag,
        completion: ((RequestOutput<U>) -> Void)?
    ) {
        uuid = bag.append(self)
        transport.perform { [weak self] error, data in
            guard let self else { return }
            let uuid = self.uuid
            if let bagDestroyableItem = self.transport as? BagDestroyableItem {
                let shouldDestroyObject = bagDestroyableItem.bagShouldDestroyItem(bag)
                if shouldDestroyObject {
                    bag.remove(uuid: uuid)
                }
            }
            else {
                bag.remove(uuid: uuid)
            }

            if let error = error {
                let output = RequestOutput<U>(error: error, payload: nil)
                completion?(output)
            }
            else if let data = data {
                background {
                    let payload = U(serializedData: data)
                    main {
                        let output = RequestOutput<U>(error: nil, payload: payload)
                        completion?(output)
                    }
                }
            }
            else {
                let output = RequestOutput<U>(error: NSError.error(localizedDescription: "Unknown error in query execution \(String(describing: self))"), payload: nil)
                completion?(output)
            }
        }
    }
}
