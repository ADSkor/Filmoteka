//
//  JSONStringSerializable.swift
//  
//
//  Created by Aleksandr Skorotkin on 03.11.2022.
//

import Foundation
import SwiftyJSON

protocol JSONStringSerializable {
    func serializeToJsonString() -> String
    static func deserializeFrom(json: JSON) -> Any?
}
