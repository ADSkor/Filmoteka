//
//  CollectionViewAdapterDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public protocol CollectionViewAdapterDelegate: AnyObject {
    func collectionViewAdapter(
        adapter: CollectionViewAdapter,
        didSelectCell cell: CollectionViewAdapterCell,
        item: CollectionCellItem
    )
    func collectionViewAdapter(
        adapter: CollectionViewAdapter,
        didReachScrollViewContentPosition: ScrollViewContentPosition
    )
    func collectionViewAdapter(
        adapter: CollectionViewAdapter,
        didScrollToDirection: ScrollViewScrollDirection
    )
    func collectionViewAdapterDidPullToRefresh(
        adapter: CollectionViewAdapter
    )
    func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didStopAtPage _: Int
    )
}

public extension CollectionViewAdapterDelegate {
    func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didSelectCell _: CollectionViewAdapterCell,
        item _: CollectionViewAdapterItem<CollectionViewAdapterCell, CollectionViewAdapterItemData>
    ) {}
    func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didReachScrollViewContentPosition _: ScrollViewContentPosition
    ) {}
    func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didScrollToDirection _: ScrollViewScrollDirection
    ) {}
    func collectionViewAdapterDidPullToRefresh(
        adapter _: CollectionViewAdapter
    ) {}
    func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didStopAtPage _: Int
    ) {}
}
