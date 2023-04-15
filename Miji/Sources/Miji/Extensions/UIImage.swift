//
//  File.swift
//  
//
//  Created by Aleksandr Skorotkin on 05.01.2023.
//

import UIKit

public extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
