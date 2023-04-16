//
//  SearchScreenViewControllerState.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation

enum SearchScreenViewControllerState {
    //specifyingSearchRequest - user typing for search
    case specifyingSearchRequest
    case fetching
    case results
    case noResults
}
