//
//  UINavigationController.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
    func safePopToViewController(
        _ viewController: UIViewController,
        animated: Bool
    ) {
        guard viewControllers.contains(viewController) else {
            debugPrint("Crash avoided for popViewController, trying to pop to missing viewController")
            return
        }
        // swiftlint:disable unsafePopToViewController
        popToViewController(
            viewController,
            animated: animated
        )
    }
}
