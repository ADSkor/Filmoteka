//
//  TableViewAdapterDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public protocol TableViewAdapterDelegate: AnyObject {
    func tableViewAdapter(
        adapter: TableViewAdapter,
        didSelectCell cell: TableViewAdapterCell,
        item: CellItem
    )

    func tableViewAdapter(
        adapter: TableViewAdapter,
        didRemoveCell cell: TableViewAdapterCell,
        item: CellItem
    )

    func tableViewAdapter(
        adapter: TableViewAdapter,
        didReachScrollViewContentPosition: ScrollViewContentPosition,
        offset: CGFloat
    )

    func tableViewAdapter(
        adapter: TableViewAdapter,
        didScrollToDirection: ScrollViewScrollDirection
    )

    func tableViewAdapterDidPullToRefresh(
        adapter: TableViewAdapter
    )
}

public extension TableViewAdapterDelegate {
    func tableViewAdapter(
        adapter _: TableViewAdapter,
        didSelectCell _: TableViewAdapterCell,
        item _: CellItem
    )
    {}

    func tableViewAdapter(
        adapter _: TableViewAdapter,
        didReachScrollViewContentPosition _: ScrollViewContentPosition,
        offset _: CGFloat
    )
    {}

    func tableViewAdapter(
        adapter _: TableViewAdapter,
        didScrollToDirection _: ScrollViewScrollDirection
    )
    {}

    func tableViewAdapter(
        adapter _: TableViewAdapter,
        didRemoveCell _: TableViewAdapterCell,
        item _: CellItem
    )
    {}

    func tableViewAdapterDidPullToRefresh(
        adapter _: TableViewAdapter
    )
    {}
}
