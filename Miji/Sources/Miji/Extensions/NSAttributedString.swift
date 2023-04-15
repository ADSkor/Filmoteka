//
//  AttributedText.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    // MARK: - Builder

    static func text(
        text: String,
        font: UIFont = .systemFont(ofSize: 14),
        textColor: UIColor = .black,
        lineHeight: CGFloat = 0,
        letterSpacing: CGFloat = 0,
        alignment: NSTextAlignment = .left
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = alignment

        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: textColor,
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.kern: letterSpacing,
            ]
        )
        return attributedText
    }
}
