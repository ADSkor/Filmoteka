//
//  UIScrollView.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToTop() {
        contentOffset = CGPoint(x: 0, y: 0)
    }
}
