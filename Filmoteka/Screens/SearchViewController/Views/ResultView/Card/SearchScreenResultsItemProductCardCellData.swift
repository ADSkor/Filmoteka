//
//  SearchScreenResultsItemProductCardCellData.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Miji
import UIKit

class SearchScreenResultsItemProductCardCellData: TableViewAdapterItemData {
    private(set) weak var delegate: SearchScreenResultsItemProductCardCellDelegate?

    let film: Film
    var isFavorite: Bool

    init(
        isFavorite: Bool,
        film: Film,
        delegate: SearchScreenResultsItemProductCardCellDelegate?
    ) {
        self.isFavorite = isFavorite
        self.film = film
        self.delegate = delegate
    }
}
