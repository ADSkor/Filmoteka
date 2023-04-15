//
//  BackendAPI.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji
import SwiftyJSON

class BackendAPI: API {
    private let context: Context

    init(
        context: Context
    ) {
        self.context = context
    }
    
    func getFilmInfo(_ input: GetFilmInfoRequestInput) -> GetFilmInfoRequest {
        let transport = AlamofireTransportRequest<GetFilmInfoRequestInput>(input)
        transport.dataSource = self
        
        let request = GetFilmInfoRequest(input, transport)
        return request
    }
}

extension BackendAPI: RequestDataSource {
    func requestServerAddress(_: Any) -> String {
        return Network.mainServer
    }
}
