//
//  toJSONString.swift
//  
//
//  Created by Aleksandr Skorotkin on 03.11.2022.
//

import Foundation


//func toJSONString(object: Any, ignoredFields: [String] = ["delegate"]) -> String? {
//    var output = ""
//    if let array = object as? [Any] {
//        output += "["
//        for item in array {
//            if let serializedObject = toJSONString(object: item) {
//                if output.count > 1 {
//                    output += ","
//                }
//                output += serializedObject
//            }
//        }
//        output += "]"
//        return output
//    }
//    var mirror = Mirror(reflecting: object)
//    if let dict = object as? [String: Any] {
//        mirror = dict.customMirror
//    }
//
//    if mirror.children.count > 0 {
//        for child in mirror.children {
//            var rawKey = child.label
//            var value = child.value
//            if rawKey?.count ?? 0 < 1 {
//                guard let pair = child.value as? (String, Any) else { continue }
//                rawKey = pair.0
//                value = pair.1
//            }
//            guard let key = rawKey, key.count > 0 else { continue }
//            let anyObject = value as AnyObject
//
//            if ignoredFields.contains(key) { continue }
//            var outputObject = ""
//            if let string = value as? String {
//                outputObject = "\"\(key)\":\"\(string.JSONEscape())\""
//            }
//            else if let value = value as? Double {
//                outputObject = "\"\(key)\":\(value)"
//            }
//            else if let value = value as? Int {
//                outputObject = "\"\(key)\":\(value)"
//            }
//            else if let value = value as? Float {
//                outputObject = "\"\(key)\":\(value)"
//            }
//            else if let value = value as? Bool {
//                outputObject = "\"\(key)\":\(value)"
//            }
//            else if let jsonSerializable = anyObject as? JSONStringSerializable {
//                outputObject = "\"\(key)\":\(jsonSerializable.serializeToJsonString())"
//            }
//            else if let serializedObject = toJSONString(object: value as AnyObject) {
//                outputObject = "\"\(key)\":\(serializedObject)"
//            }
//            if outputObject.count > 0, output.count > 0 {
//                output += ","
//            }
//            output += outputObject
//        }
//    }
//    else {
//        let anyObject = object as AnyObject
//        var outputObject = ""
//        if let string = object as? String {
//            outputObject = string.JSONEscape()
//        }
//        else if let value = object as? Int {
//            outputObject = "\(value)"
//        }
//        else if let value = object as? Double {
//            outputObject = "\(value)"
//        }
//        else if let value = object as? Float {
//            outputObject = "\(value)"
//        }
//        else if let value = object as? Bool {
//            outputObject = "\(value)"
//        }
//        else if let jsonSerializable = anyObject as? JSONStringSerializable {
//            outputObject = "\(jsonSerializable.serializeToJsonString())"
//        }
//        if outputObject.count > 0, output.count > 0 {
//            output += ","
//        }
//        output += outputObject
//        return output
//    }
//
//    return "{\(output)}"
//}
