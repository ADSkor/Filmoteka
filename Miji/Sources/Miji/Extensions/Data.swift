//
//  Data.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print("error:", error)
            return nil
        }
    }

    func asString() -> String? {
        String(data: self, encoding: .utf8)
    }

    func asBytes() -> [UInt8] {
        [UInt8](self)
    }
}
