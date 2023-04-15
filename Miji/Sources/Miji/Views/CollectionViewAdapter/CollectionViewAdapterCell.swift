//
//  CollectionViewAdapterCell.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public typealias CollectionCellItem = CollectionViewAdapterItem<CollectionViewAdapterCell, CollectionViewAdapterItemData>

open class CollectionViewAdapterCell: UICollectionViewCell {
    public weak var delegate: CollectionViewAdapterCellDelegate?

    open func fill(data _: CollectionViewAdapterItemData) {}
}
