//
//  TableView.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import UIKit

public class TableView: UITableView {
    private let adapter = TableViewAdapter()

    public func fill(_ items: [CellItem]) {
        adapter.tableView = self
        adapter.set(items: items)
    }
}
