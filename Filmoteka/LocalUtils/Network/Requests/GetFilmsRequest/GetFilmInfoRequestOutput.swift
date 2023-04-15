//
//  GetFilmInfoRequestOutput.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji
import SwiftyJSON

class GetFilmInfoRequestOutput: SerializedData {
    var json: JSON = JSON("")

    public required init(serializedData: Any) {
        super.init(serializedData: serializedData)
        guard let json = serializedData as? JSON else { return }
        self.json = json
    }
}
