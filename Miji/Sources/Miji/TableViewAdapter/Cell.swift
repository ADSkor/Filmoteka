//
//  Cell.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

open class Cell<Data: TableViewAdapterItemData>: TableViewAdapterCell {
    public weak var data: Data? { cellItemData as? Data }

    public static func item(
        identifier: String = UUID().uuidString,
        _ data: Data
    ) -> CellItem {
        return CellItem(
            identifier: identifier,
            cellClass: Self.self,
            data: data
        )
    }
}
