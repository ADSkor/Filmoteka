//
//  GlobalVars.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public var isSimulator: Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}

public var RandomUUID: String {
    UUID().uuidString
}

public var StatusBarFrame: CGRect? {
    KeyWindow?.windowScene?.statusBarManager?.statusBarFrame
}

public var KeyWindow: UIWindow? {
    UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }
}
