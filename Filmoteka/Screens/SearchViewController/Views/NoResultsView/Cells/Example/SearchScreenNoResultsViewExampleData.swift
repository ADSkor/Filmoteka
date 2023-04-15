//
//  SearchScreenNoResultsViewExampleData.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class SearchScreenNoResultsViewExampleData: TableViewAdapterItemData {
    private(set) weak var delegate: SearchScreenNoResultsViewExampleDelegate?
    var example: String
    
    init(
        example: String,
        delegate: SearchScreenNoResultsViewExampleDelegate?
    ) {
        self.example = example
        self.delegate = delegate
    }
}
