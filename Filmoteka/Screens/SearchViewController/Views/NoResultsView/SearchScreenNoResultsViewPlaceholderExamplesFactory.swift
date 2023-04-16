//
//  SearchScreenNoResultsViewPlaceholderExamplesFactory.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Miji

//Factory
class PlaceholderExamples {
    @CellItemsBuilder static func search(
        searchText: String,
        examples: [String],
        view: SearchScreenNoResultsView
    ) -> [CellItem] {
        EmptySpaceCell.item(height: 24)
        for example in examples {
            SearchScreenNoResultsViewExample.item(
                example: example,
                delegate: view
            )
            EmptySpaceCell.item(height: 8)
        }
    }
}
