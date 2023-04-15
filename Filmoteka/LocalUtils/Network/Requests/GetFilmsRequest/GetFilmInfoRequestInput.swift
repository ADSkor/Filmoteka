//
//  GetFilmInfoRequestInput.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class GetFilmInfoRequestInput: CachedRequestInput {
    let endpointString: String
    let cacheOptions: CacheOptions?

    init(
        endpointString: String,
        cacheOptions: CacheOptions?
    ) {
        self.endpointString = endpointString
        self.cacheOptions = cacheOptions
    }
}

extension GetFilmInfoRequestInput: HTTPRequestInput {
    func headers() -> HTTPHeaders {
        [:]
    }

    func endpoint() -> String {
        return endpointString
    }

    func type() -> HTTPRequestType {
        return .GET
    }
}
