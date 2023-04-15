//
//  KeyboardAutomaticContraint.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public class KeyboardAutomaticContraint: NSLayoutConstraint {
    private var offset: CGFloat = 0
    private var keyboardVisibleHeight: CGFloat = 0

    override public func awakeFromNib() {
        super.awakeFromNib()

        offset = constant

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardAutomaticContraint.keyboardWillShowNotification(_:)),
            name: UIWindow.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardAutomaticContraint.keyboardWillHideNotification(_:)),
            name: UIWindow.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Notification

    @objc func keyboardWillShowNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height
            }

            updateConstant()
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):

                let options = UIView.AnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        KeyWindow?.layoutIfNeeded()
                    }, completion: { _ in
                    }
                )
            default:

                break
            }
        }
    }

    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        keyboardVisibleHeight = 0
        updateConstant()

        if let userInfo = notification.userInfo {
            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):

                let options = UIView.AnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        KeyWindow?.layoutIfNeeded()
                    }, completion: { _ in
                    }
                )
            default:
                break
            }
        }
    }

    func updateConstant() {
        constant = offset + keyboardVisibleHeight
    }
}
