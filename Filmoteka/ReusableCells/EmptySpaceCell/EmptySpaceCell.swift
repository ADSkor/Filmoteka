//
//  EmptySpaceCell.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Miji
import UIKit

//One of Reusable Cells
class EmptySpaceCell: TableViewAdapterCell {
    static func item(
        identifier: String = UUID().uuidString,
        backgroundColor: UIColor = .clear,
        height: CGFloat
    ) -> CellItem {
        return CellItem(
            identifier: identifier,
            cellClass: EmptySpaceCell.self,
            data: EmptySpaceCellData(
                backgroundColor: backgroundColor,
                emptySpace: height
            )
        )
    }

    override func fill(data: TableViewAdapterItemData) {
        guard let data = data as? EmptySpaceCellData else { return }
        backgroundColor = data.backgroundColor
    }
}
