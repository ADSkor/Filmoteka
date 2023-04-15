//
//  API.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

protocol API: AnyObject {
    typealias GetFilmInfoRequest = Request<GetFilmInfoRequestInput, GetFilmInfoRequestOutput>
    func getFilmInfo(
        _ input: GetFilmInfoRequestInput
    ) -> GetFilmInfoRequest
}
