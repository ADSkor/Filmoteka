//
//  CollectionViewAdapterItem.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public struct CollectionViewAdapterItem<T: CollectionViewAdapterCell, U: CollectionViewAdapterItemData> {
    public let identifier: String
    public let cellClass: T.Type
    public let data: CollectionViewAdapterItemData
    public let reuseIdentifier: String

    public init(identifier: String = UUID().uuidString, cellClass: T.Type, data: U) {
        self.identifier = identifier
        self.cellClass = cellClass
        self.data = data
        reuseIdentifier = String(describing: cellClass)
    }
}
