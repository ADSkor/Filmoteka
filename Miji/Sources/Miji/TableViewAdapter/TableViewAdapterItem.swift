//
//  TableViewAdapterItem.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public struct TableViewAdapterItem<T: TableViewAdapterCell, U: TableViewAdapterItemData> {
    public let identifier: String
    public let cellClass: T.Type
    public let data: U
    let reuseIdentifier: String

    public init(identifier: String = UUID().uuidString, cellClass: T.Type, data: U) {
        self.identifier = identifier
        self.cellClass = cellClass
        self.data = data
        reuseIdentifier = String(describing: cellClass)
    }

    var height: CGFloat {
        return data.height()
    }

    var canEdit: Bool {
        return data.canEdit()
    }
}

extension TableViewAdapterItem: Hashable {
    public static func == (
        lhs: TableViewAdapterItem<T, U>,
        rhs: TableViewAdapterItem<T, U>
    ) -> Bool {
        return
            lhs.identifier == rhs.identifier &&
            lhs.reuseIdentifier == rhs.reuseIdentifier
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(reuseIdentifier)
    }
}
