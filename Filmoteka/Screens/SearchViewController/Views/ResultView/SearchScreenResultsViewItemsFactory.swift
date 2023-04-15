//
//  SearchScreenResultsViewItemsFactory.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Miji
import UIKit

class SearchScreenResultsViewItemsFactory {
    static func items(
        films: [Film]?,
        resultsView: SearchScreenResultsView,
        appContext: AppContext?
    ) -> [CellItem] {
        var items: [CellItem] = []
        
        guard let films else { return items }
        
        films.forEach { film in
            items.append(EmptySpaceCell.item(height: 8))
            items.append(SearchScreenResultsItemProductCardCell.item(
                isFavorite: appContext?.favoritesMovies.contains(film.id) ?? false,
                film: film,
                delegate: resultsView))
            items.append(EmptySpaceCell.item(height: 8))
            items.append(EmptySpaceCell.item(
                backgroundColor: .gray,
                height: 0.5)
            )
        }
        
        if items.count > 1 {
            items.removeLast()
        }
        
        return items
    }
}
