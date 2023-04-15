//
//  ViewController.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public extension UIViewController {
    static func fromStoryboard<T: UIViewController>() -> T {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() as? T {
            return initialViewController
        }

        fatalError("Can't initialize view controller \(self)")
    }

    func popTo(_ viewController: UIViewController, animated _: Bool = true) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        guard viewControllers.contains(viewController) else { return }
        while let poppedViewController = viewControllers.popLast() {
            if poppedViewController == viewController {
                break
            }
            else {
                (poppedViewController as? AppearanceEventsViewController)?.viewWillPop()
            }
        }
        navigationController?.safePopToViewController(self, animated: true)
    }

    func popBack(animated: Bool = true) {
        (self as? AppearanceEventsViewController)?.viewWillPop()
        // swiftlint:disable legacyPopViewController
        navigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        _ = viewControllers.popFirst()
        viewControllers.forEach {
            ($0 as? AppearanceEventsViewController)?.viewWillPop()
        }
        navigationController?.popToRootViewController(animated: animated)
    }

    func showModal(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        present(
            viewController,
            animated: animated
        )
    }

    func push(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }

    func showAlert(
        title: String,
        message: String? = nil,
        okButtonTitle: String = "OK",
        noButtonTitle: String? = nil,
        completion: (() -> Void)? = nil
    ) {
        if let debuggableViewController = self as? DebuggableViewController {
            let debugInfo = DebugInfo.alert(
                title: title,
                message: message,
                okButtonTitle: okButtonTitle,
                noButtonTitle: noButtonTitle
            )
            debuggableViewController.debugNotification(
                debugInfo: debugInfo
            )
        }

        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: okButtonTitle,
            style: .default,
            handler: { _ in
                if let completion = completion {
                    completion()
                }
            }
        )

        if let noButtonTitle = noButtonTitle {
            let noAction = UIAlertAction(
                title: noButtonTitle,
                style: .cancel,
                handler: { _ in
                    // Do nothing
                }
            )
            alertViewController.addAction(noAction)
        }

        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }

    func showUnknownServerError(reason: String = "Unknown error") {
        showAlert(title: reason)
    }

    func show(_ error: Error, completion: (() -> Void)? = nil) {
        showAlert(title: "\(error.localizedDescription) (\((error as NSError).code))", completion: completion)
    }

    func prompt(
        title: String,
        message: String? = nil,
        yesText: String = "Yes",
        noText: String = "No",
        yesBlock: (() -> Void)?,
        noBlock: (() -> Void)? = nil
    ) {
        if let debuggableViewController = self as? DebuggableViewController {
            let debugInfo = DebugInfo.prompt(
                title: title,
                message: message,
                yesButtonTitle: yesText,
                noButtonTitle: noText
            )
            debuggableViewController.debugNotification(
                debugInfo: debugInfo
            )
        }
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let yesAction = UIAlertAction(
            title: yesText,
            style: .default,
            handler: { _ in
                yesBlock?()
            }
        )

        let noAction = UIAlertAction(
            title: noText,
            style: .default,
            handler: { _ in
                noBlock?()
            }
        )

        alertViewController.addAction(yesAction)
        alertViewController.addAction(noAction)

        present(alertViewController, animated: true, completion: nil)
    }

    static func safeAreaTopHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            return KeyWindow?.safeAreaInsets.top ?? 0.0
        }
        else {
            return 0
        }
    }
}
