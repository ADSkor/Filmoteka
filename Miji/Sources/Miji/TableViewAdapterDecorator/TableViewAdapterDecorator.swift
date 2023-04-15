//
//  ViewController.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public class TableViewAdapterDecorator {
    private let tableViewAdapter = TableViewAdapter()

    private weak var tableView: UITableView?
    private weak var delegate: TableViewAdapterDecoratorDelegate?
    private weak var dataSource: TableViewAdapterDecoratorDataSource?

    public init<T: UIViewController & TableViewAdapterDecoratorDelegate>(
        viewController: T,
        tableView: UITableView?,
        dataSource: TableViewAdapterDecoratorDataSource
    ) {
        self.tableView = tableView
        self.tableView?.dataSource = tableViewAdapter
        self.dataSource = dataSource
        delegate = viewController
    }

    public func reloadData() {
        let items = dataSource?.tableViewAdapterDecoratorItems(self) ?? []
        tableViewAdapter.set(items: items)
    }

    public func cellAndData<T, Z>(forIdentifier identifier: String) -> (T?, Z?) {
        let cell = tableViewAdapter.visibleCellFor(identifier: identifier) as? T
        let cellData = tableViewAdapter.cellDataFor(identifier: identifier) as? Z

        return (cell, cellData)
    }

    public func scrollToCell(
        identifier: String,
        at position: UITableView.ScrollPosition = .top,
        needFocus: Bool = true,
        focusTimeout: Double = 0.15
    ) {
        guard let row = tableViewAdapter.rowFor(identifier: identifier) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView?.scrollToRow(at: indexPath, at: position, animated: true)
        if needFocus {
            main(delay: focusTimeout) {
                if let cell = self.tableViewAdapter.visibleCellFor(
                    identifier: identifier
                ) as? Focusable {
                    cell.setFocus()
                }
            }
        }
    }

    public func insertItemIfNeeded(
        item: CellItem,
        after identifier: String
    ) {
        tableViewAdapter.insertItems(
            itemsToInsert: [item],
            after: identifier
        )
    }

    public func reloadItem(
        identifier: String
    ) {
        tableViewAdapter.reloadItems(identifiers: [identifier])
    }

    public func removeItemIfNeeded(
        identifier: String
    ) {
        tableViewAdapter.removeItems(
            identifiers: [identifier]
        )
    }

    public func itemsCount() -> Int {
        return tableViewAdapter.itemsCount()
    }
}

extension TableViewAdapterDecorator: ViewControllerDecorator {
    public func decorate() {
        tableViewAdapter.tableView = tableView
        tableViewAdapter.delegate = self
    }
}

extension TableViewAdapterDecorator: TableViewAdapterDelegate {
    public func tableViewAdapter(
        adapter _: TableViewAdapter,
        didSelectCell cell: TableViewAdapterCell,
        item: CellItem
    ) {
        delegate?.tableViewAdapterDecorator(
            self,
            didSelectCell: cell,
            item: item
        )
    }

    public func tableViewAdapter(adapter _: TableViewAdapter, didReachScrollViewContentPosition position: ScrollViewContentPosition, offset: CGFloat) {
        delegate?.tableViewAdapterDecorator(self, didReachScrollViewContentPosition: position, offset: offset)
    }

    public func tableViewAdapter(
        adapter _: TableViewAdapter,
        didScrollToDirection direction: ScrollViewScrollDirection
    ) {
        delegate?.tableViewAdapterDecorator(self, didScrollToDirection: direction)
    }
}
