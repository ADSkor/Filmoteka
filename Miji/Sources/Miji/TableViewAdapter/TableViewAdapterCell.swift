//
//  TableViewAdapterCell.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

open class TableViewAdapterCell: UITableViewCell {
    public var cellItemData: TableViewAdapterItemData?

    public weak var delegate: TableViewAdapterCellDelegate?

    open func fill(data _: TableViewAdapterItemData) {}

    open func fill() {}
}
