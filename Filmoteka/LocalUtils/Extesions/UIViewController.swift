//
//  UIViewController.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji
import UIKit

extension UIViewController {

    func setupToHideKeyboardOnTapOnView() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard)
        )

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    //To show anything when we need to
    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        }
        else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        }
        else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        }
        else {
            return self
        }
    }
}

//get your own bag
class CustomViewController: UIViewController {
    let bag: Bag = .init()

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("❌ ViewController viewDidDisappear: \(Self.self)")
        bag.clean()
    }
}
