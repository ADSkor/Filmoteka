//
//  UIButton.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public extension UIButton {
    func enable(minFontScaleFactor: CGFloat) {
        titleLabel?.minimumScaleFactor = minFontScaleFactor
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
    }

    func set(title: String?) {
        setTitle(title, for: .normal)
    }

    func set(textColor: UIColor) {
        setTitleColor(textColor, for: .normal)
    }

    func set(font: UIFont) {
        titleLabel?.font = font
    }

    func set(image: UIImage?) {
        setImage(image, for: .normal)
    }
}
