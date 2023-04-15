//
//  NSError.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension NSError {
    static func error(domain: String = "Default Domain", code: Int = 0, localizedDescription: String, payload: Any = [:]) -> Error {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription, "payload": payload]
        let error = NSError(
            domain: domain,
            code: code,
            userInfo: userInfo
        )
        return error
    }

    static func unknownInternalError(
        domain: String = "Unknown Domain",
        code: Int = -1,
        localizedDescription: String = "Unknown error"
    ) -> Error {
        return error(domain: domain, code: code, localizedDescription: localizedDescription)
    }

    static func unknownServerError(
        domain: String = "Unknown Domain",
        code: Int? = nil,
        localizedDescription: String = "Unknown server error"
    ) -> Error {
        let code = code ?? -1
        return error(domain: domain, code: code, localizedDescription: localizedDescription)
    }
    
    static func errorFrom(json: JSON, defaultStatusCode: Int = -1) -> Error? {
        if json["message"].string != nil {
            let payload = json["message"].stringValue
            let error = json["error"].stringValue
            let status = json["status"].stringValue.asInt()
            let path = json["path"].stringValue
            let trace = "\(String(describing: status)) \(error) \n\(path)\n\(payload)"
            let payloadJsonString = payload.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\\", with: "\\\\")
            let payloadJson = Utils().loadJSON(jsonString: payloadJsonString)
            let localizedDescription = payloadJson?["message"].string ?? json["message"].string ?? "Unknown serveer error"
            return NSError.error(
                domain: path,
                code: status ?? defaultStatusCode,
                localizedDescription: localizedDescription,
                payload: trace
            )
        }
        else if let error = json["message"].string {
            let status = json["status"].int ?? defaultStatusCode
            let stackTrace = json["stackTrace"].string ?? "-"
            return NSError.error(
                domain: "Network",
                code: status,
                localizedDescription: error,
                payload: stackTrace
            )
        }
        else if let error = json["error"].string, error.count > 0 {
            let status = json["status"].int ?? defaultStatusCode
            let stackTrace = json["stackTrace"].string ?? "-"
            return NSError.error(
                domain: "Network",
                code: status,
                localizedDescription: error,
                payload: stackTrace
            )
        }
        return nil
    }
}

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
