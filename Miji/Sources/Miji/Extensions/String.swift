//
//  String.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import SwiftyJSON
import UIKit

public extension String {
    func urlComponents() -> URLComponents? {
        return URLComponents(string: self)
    }

//    static func LoadJSON(jsonString: String?) -> JSON? {
//        guard let jsonString else { return nil }
//        guard let serializedDataString = jsonString.data(using: .utf8, allowLossyConversion: false) else { return nil }
//        do {
//            let json = try JSON(data: serializedDataString)
//            return json
//        }
//        catch {
//            #if DEBUG
//                debugPrint(jsonString)
//                debugPrint("JSON parsion error: \(error)")
//            #endif
//            return nil
//        }
//    }
    
    func asInt() -> Int? {
        return Int(self)
    }

    func asIntOrZero() -> Int {
        return Int(self) ?? 0
    }

    func lastPathComponent(separator: String = "/") -> String {
        split(separator).last ?? ""
    }

    func capitalizingFirstLetter() -> String {
        guard count > 0 else { return self }
        return prefix(1).capitalized + lowercased().dropFirst()
    }

    func gaString() -> String {
        let output = replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").lowercased()
        return output
    }

    func prefix(to offset: Int) -> String {
        return String(prefix(offset))
    }

    func suffix(length: Int) -> String {
        return String(suffix(length))
    }

    func firebaseTrim() -> String {
        var output = self
        if output.first == "\"" {
            output.removeFirst()
        }
        if output.last == "\"" {
            output.removeLast()
        }
        return output
    }

    func at(_ offset: Int) -> String {
        guard offset >= 0 else { return "" }
        guard offset < count else { return "" }
        return String(self[index(startIndex, offsetBy: offset)])
    }

    func asJSON() -> JSON? {
        return Utils().loadJSON(jsonString: self)
    }

    func containsLowercased() -> Bool {
        for character in self {
            if String(character).lowercased() != String(character) {
                return true
            }
        }

        return false
    }

    func containsUppercased() -> Bool {
        for character in self {
            if String(character).uppercased() != String(character) {
                return true
            }
        }

        return false
    }

    func digits() -> String {
        return filter("0123456789".contains)
    }

    var wordsCount: Int {
        split(" ").count
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }

    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }

    func lowcasedFirstLetter() -> String {
        guard count > 0 else { return self }
        return prefix(1).lowercased() + dropFirst()
    }

    func urlEncoded() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    func JSONEscape() -> String {
        return replacingOccurrences(of: "\n", with: "\\n").replacingOccurrences(of: "\"", with: "\\\"")
    }

    func asData() -> Data? {
        data(using: .utf8)
    }

    func asDouble() -> Double? {
        return Double(self)
    }

    func htmlEscaped() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }

    func htmlEscapedOrOriginal() -> String {
        return htmlEscaped() ?? self
    }

    func uniSearchFormat() -> String {
        return lowercased().trimmingCharacters(in: .whitespaces)
    }

    func uniSearch(_ text: String?) -> Bool {
        guard let text = text?.uniSearchFormat() else { return false }
        return uniSearchFormat().contains(text)
    }

    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func asDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    var unicodeEscaped: String {
        unicodeScalars.map { "\\U\(String(format: "%04x", $0.value))" }.joined()
    }

    var intro: String {
        prefix(to: 30) + "..."
    }

    var outro: String {
        "..." + suffix(length: 30)
    }

    var shortIntro: String {
        prefix(to: 4) + "..."
    }

    var shortOutro: String {
        "..." + suffix(length: 4)
    }

    var short: String { "\(shortIntro)\(shortOutro)" }

    var introOutro: String { "\(intro)\(outro)" }

    func trimmedHTMLTags() -> String {
        guard let htmlStringData = data(using: String.Encoding.utf8) else {
            return ""
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
        ]

        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string ?? ""
    }

    func pureURL() -> String? {
        asURL()?.pureURL()?.asString()
    }

    func asURL() -> URL? {
        URL(string: self)
    }
}

public extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }

    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
