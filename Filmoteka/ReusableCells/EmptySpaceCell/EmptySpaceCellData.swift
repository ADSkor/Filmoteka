//
//  EmptySpaceCellData.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Miji
import UIKit

class EmptySpaceCellData: TableViewAdapterItemData {
    let backgroundColor: UIColor
    let emptySpace: CGFloat

    init(backgroundColor: UIColor, emptySpace: CGFloat = 16) {
        self.backgroundColor = backgroundColor
        self.emptySpace = emptySpace
    }

    override func height() -> CGFloat {
        return emptySpace
    }
}
