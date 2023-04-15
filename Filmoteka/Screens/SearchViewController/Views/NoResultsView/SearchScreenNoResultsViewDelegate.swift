//
//  SearchScreenNoResultsViewDelegate.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation

protocol SearchScreenNoResultsViewDelegate: AnyObject {
    func searchScreenNoResultsView(
        _ view: SearchScreenNoResultsView,
        didTapOn example: String
    )
}
