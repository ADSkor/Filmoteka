//
//  UILabel.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public extension UILabel {
    func set(
        adaptiveText text: String,
        numberOfLines: Int,
        defaultScaleFactor: CGFloat = 1.0
    ) {
        self.text = text
        self.numberOfLines = text.wordsCount > 1 ? numberOfLines : 1
        minimumScaleFactor = text.wordsCount > 1 ? defaultScaleFactor : defaultScaleFactor * 0.8
    }
}
