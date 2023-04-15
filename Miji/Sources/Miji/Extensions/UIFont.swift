//
//  UIFont.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    static func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., size: CGFloat) -> UIFont {
        guard let descriptor = UIFontDescriptor().withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else { return UIFont.systemFont(ofSize: 18) }
        return UIFont(descriptor: descriptor, size: size)
    }

    static func boldItalicFont(size: CGFloat) -> UIFont {
        return withTraits(.traitItalic, .traitBold, size: size)
    }
}
