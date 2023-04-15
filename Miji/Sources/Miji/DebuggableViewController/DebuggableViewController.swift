//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public protocol DebuggableViewController {
    func debugNotification(
        debugInfo: String
    )
    func promptYesBlockSelected(
        yesText: String,
        title: String,
        message: String
    )
    func promptNoBlockSelected(
        noText: String,
        title: String,
        message: String
    )
}
