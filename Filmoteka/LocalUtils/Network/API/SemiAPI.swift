//
//  SemiAPI.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class SemiAPI: API {
    private let appContext: AppContext
    private lazy var mockAPI = MockAPI(appContext: self.appContext)
    private lazy var backendAPI = BackendAPI(appContext: self.appContext)

    @PersistentGlobalVariable(SemiAPIFlags.MOCK_GET_FILM_INFO.rawValue, false)
    private var mockGetFilmInfoEnabled: Bool

    init(appContext: AppContext) {
        self.appContext = appContext
    }
    
    func getFilmInfo(_ input: GetFilmInfoRequestInput) -> GetFilmInfoRequest {
        return mockGetFilmInfoEnabled ? mockAPI.getFilmInfo(input) : backendAPI.getFilmInfo(input)
    }
}
