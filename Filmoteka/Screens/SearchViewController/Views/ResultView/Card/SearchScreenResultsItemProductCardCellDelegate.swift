//
//  SearchScreenResultsItemProductCardCellDelegate.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

protocol SearchScreenResultsItemProductCardCellDelegate: AnyObject {
    func searchScreenResultsItemProductCardCell(
        _ cell: SearchScreenResultsItemProductCardCell,
        didSelect film: Film
    )
    
    func searchScreenResultsItemProductCardCell(
        _ cell: SearchScreenResultsItemProductCardCell,
        didTapFavorite film: Film
    )
}
