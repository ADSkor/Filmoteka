//
//  TableViewAdapterDecoratorDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public protocol TableViewAdapterDecoratorDelegate: AnyObject {
    func tableViewAdapterDecorator(
        _ decorator: TableViewAdapterDecorator,
        didSelectCell cell: TableViewAdapterCell,
        item: CellItem
    )

    func tableViewAdapterDecorator(
        _ decorator: TableViewAdapterDecorator,
        didReachScrollViewContentPosition: ScrollViewContentPosition,
        offset: CGFloat
    )

    func tableViewAdapterDecorator(
        _: TableViewAdapterDecorator,
        didScrollToDirection: ScrollViewScrollDirection
    )
}

public extension TableViewAdapterDecoratorDelegate {
    func tableViewAdapterDecorator(
        _: TableViewAdapterDecorator,
        didReachScrollViewContentPosition _: ScrollViewContentPosition,
        offset _: CGFloat
    ) {}
    func tableViewAdapterDecorator(
        _: TableViewAdapterDecorator,
        didScrollToDirection _: ScrollViewScrollDirection
    ) {}
}
