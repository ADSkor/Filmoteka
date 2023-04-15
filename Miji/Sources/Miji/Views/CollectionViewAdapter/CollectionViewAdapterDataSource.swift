//
//  CollectionViewAdapterDataSource.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public protocol CollectionViewAdapterDataSource: AnyObject {
    func collectionViewAdapter(
        _ adapter: CollectionViewAdapter,
        sizeForItem: CollectionCellItem
    ) -> CGSize
    func collectionViewAdapterEdgeInsets(_ adapter: CollectionViewAdapter) -> UIEdgeInsets
    func collectionViewAdapterMinimumLineSpacing(_ adapter: CollectionViewAdapter) -> CGFloat
    func collectionViewAdapterMinimumInterItemSpacing(_ adapter: CollectionViewAdapter) -> CGFloat
}

public extension CollectionViewAdapterDataSource {
    func collectionViewAdapter(
        _: CollectionViewAdapter,
        sizeForItem _: CollectionCellItem
    ) -> CGSize {
        .zero
    }

    func collectionViewAdapterEdgeInsets(_: CollectionViewAdapter) -> UIEdgeInsets {
        .zero
    }

    func collectionViewAdapterMinimumLineSpacing(_: CollectionViewAdapter) -> CGFloat {
        .zero
    }

    func collectionViewAdapterMinimumInterItemSpacing(_: CollectionViewAdapter) -> CGFloat {
        .zero
    }
}
