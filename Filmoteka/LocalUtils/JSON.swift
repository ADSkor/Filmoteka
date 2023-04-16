//
//  JSON.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import SwiftyJSON

//We can use to load JSON from file, most of all for Mock tests.
extension JSON {
    static func from(filename: String) -> JSON? {
        let resource = filename.split(".").at(0)
        let type = filename.split(".").at(1)
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else { return nil }
        guard let data = try? String(contentsOfFile: path).data(using: .utf8) else { return nil }
        let json = try? JSON(data: data)
        return json
    }
}
