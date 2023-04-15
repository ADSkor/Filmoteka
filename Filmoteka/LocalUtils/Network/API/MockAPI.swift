//
//  MockAPI.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class MockAPI: API {
    private let context: Context

    init(
        context: Context
    ) {
        self.context = context
    }

    func getFilmInfo(_ input: GetFilmInfoRequestInput) -> GetFilmInfoRequest {
        return Request(input, MockupTransportRequest<GetFilmInfoRequestInput>(input))
    }
}
