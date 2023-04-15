//
//  TableViewAdapterItemData.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

open class TableViewAdapterItemData {
    public init() {}

    open func canEdit() -> Bool {
        return false
    }

    open func height() -> CGFloat {
        return UITableView.automaticDimension
    }
}
