//
//  SearchScreenDataFetcher.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import SwiftyJSON
import Miji

class SearchScreenDataFetcher {
    weak var delegate: SearchScreenDataFetcherDelegate?

    private var fetchingInProgress = false
    private let appContext: AppContext

    //Bag for cache and for elements
    private let bag: Bag = .init()

    init(
        appContext: AppContext,
        delegate: SearchScreenDataFetcherDelegate?
    ) {
        self.appContext = appContext
        self.delegate = delegate
    }

    //automatic fetcher return output
    func fetch(endpointString: String) {
        guard !fetchingInProgress else { return }
        fetchingInProgress = true
        //MARK: - cacheOptions for cache. Offline acces for 2 hours in that example
        appContext.api.getFilmInfo(
            GetFilmInfoRequestInput(
                endpointString: endpointString,
                cacheOptions: (.timeInterval(.Hours(2)), endpointString)
            )
        )
        .perform(bag) { [weak self] output in
            guard let self else { return }
            self.fetchingInProgress = false
            if let error = output.error {
                self.delegate?.searchScreenDataFetcher(self, didFetch: error)
            }
            guard let payload = output.payload else { return }
            self.delegate?.searchScreenDataFetcher(self, didFetch: payload.fullFilmsInfo)
        }
    }
}

protocol SearchScreenDataFetcherDelegate: AnyObject {
    func searchScreenDataFetcher(
        _ fetcher: SearchScreenDataFetcher,
        didFetch fullFilmsInfo: FullFilmsInfo
    )

    func searchScreenDataFetcher(
        _ fetcher: SearchScreenDataFetcher,
        didFetch error: Error?
    )
}
