//
//  TopwindowController.swift
//  AnyApp
//
//  Created by Aleksandr Skorotkin on 09.01.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public final class TopWindowController<T: UIWindow> {
    private var window: UIWindow?
    private weak var viewController: UIViewController?

    public init(viewController: UIViewController) {
        window = T(frame: UIScreen.main.bounds)
        self.viewController = viewController
        window?.backgroundColor = UIColor.clear
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
