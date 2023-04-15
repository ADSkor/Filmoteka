//
//  UIActivityIndicatorView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import UIKit

public extension UIActivityIndicatorView {
    func start(color: UIColor = .systemBlue) {
        startAnimating()
        isHidden = false
        self.color = color
    }

    func stop() {
        stopAnimating()
        isHidden = true
    }
}
