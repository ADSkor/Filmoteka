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

public extension ObservableObject {
    func didChange(cancellables: inout Set<AnyCancellable>, callback: (() -> Void)?) {
        objectWillChange.sink { _ in
            main {
                callback?()
            }
        }.store(in: &cancellables)
    }
}
