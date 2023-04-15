//
//  SemiAPI.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class SemiAPI: API {
    private let context: Context
    private lazy var mockAPI = MockAPI(context: self.context)
    private lazy var backendAPI = BackendAPI(context: self.context)

    @PersistentGlobalVariable(SemiAPIFlags.MOCK_GET_FILM_INFO.rawValue, false)
    private var mockGetFilmInfoEnabled: Bool

    init(context: Context) {
        self.context = context
    }
    
    func getFilmInfo(_ input: GetFilmInfoRequestInput) -> GetFilmInfoRequest {
        return mockGetFilmInfoEnabled ? mockAPI.getFilmInfo(input) : backendAPI.getFilmInfo(input)
    }
}
