//
//  TableViewAdapter.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public class TableViewAdapter: NSObject {
    public weak var delegate: TableViewAdapterDelegate?
    public weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.keyboardDismissMode = .onDrag
            tableView?.separatorStyle = .none
        }
    }

    private var items: [CellItem] = []
    private var identifierToVisibleCells: [String: TableViewAdapterCell] = [:]
    private var identifierToItemsData: [String: TableViewAdapterItemData] = [:]

    private var refreshControl = UIRefreshControl()
    private var pullToRefreshFunction: (() -> Void)?

    private var lastContentOffset: CGFloat = 0

    private var registeredIdentifiers = Set<String>()

    // MARK: - Private

    private func cellAt(_ indexPath: IndexPath) -> TableViewAdapterCell? {
        let item = items[indexPath.row]
        let cellIdentifier = item.reuseIdentifier
        let cell = tableView?.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewAdapterCell
        cell?.delegate = self
        return cell
    }

    @objc private func handlePullToRefresh() {
        delegate?.tableViewAdapterDidPullToRefresh(adapter: self)
    }

    // MARK: - Interface

    public func stopPullToRefreshControl() {
        refreshControl.endRefreshing()
    }

    public func scrollToTop() {
        tableView?.scrollToTop()
    }

    public func scrollToBottom() {
        guard let identifier = items.last?.identifier else { return }
        scrollTo(identifier: identifier)
    }

    public func reload(cell: TableViewAdapterCell, animation: UITableView.RowAnimation = .automatic) {
        guard let indexPath = tableView?.indexPath(for: cell) else { return }
        tableView?.reloadRows(at: [indexPath], with: animation)
    }

    public func itemsCount() -> Int {
        return items.count
    }

    public func set(scrollingEnabled: Bool) {
        tableView?.isScrollEnabled = scrollingEnabled
    }

    public func enablePullToRefresh() {
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        tableView?.addSubview(refreshControl)
    }

    public func set(items: [CellItem]) {
        self.items = items
        identifierToVisibleCells.removeAll()

        items.forEach {
            let nib = UINib(
                nibName: $0.reuseIdentifier,
                bundle: nil
            )

            if registeredIdentifiers.contains($0.reuseIdentifier) == false {
                tableView?.register(
                    nib,
                    forCellReuseIdentifier: $0.reuseIdentifier
                )
                registeredIdentifiers.insert($0.reuseIdentifier)
            }
            identifierToItemsData[$0.identifier] = $0.data
        }

        tableView?.reloadData()
    }

    public func rowFor(identifier: String) -> Int? {
        return items.firstIndex { $0.identifier == identifier }
    }

    public func visibleCellFor(identifier: String) -> TableViewAdapterCell? {
        return identifierToVisibleCells[identifier]
    }

    public func cellDataFor(identifier: String) -> TableViewAdapterItemData? {
        return identifierToItemsData[identifier]
    }

    public func reloadItems(
        rows: [Int],
        animation: UITableView.RowAnimation = .automatic
    ) {
        let indexPaths = rows.compactMap {
            IndexPath(
                row: $0,
                section: 0
            )
        }

        tableView?.beginUpdates()
        tableView?.reloadRows(
            at: indexPaths,
            with: animation
        )
        tableView?.endUpdates()
    }

    public func reloadItems(
        identifiers: [String],
        animation: UITableView.RowAnimation = .automatic
    ) {
        let rows: [Int] = identifiers.compactMap { identifier in
            guard let row = items.firstIndex(where: {
                $0.identifier == identifier
            })
            else {
                debugPrint("😔 Can't find row for identifier: \(identifier)")
                return nil
            }
            return row
        }
        reloadItems(
            rows: rows,
            animation: animation
        )
    }

    public func add(
        itemsToAdd: [CellItem],
        animation: UITableView.RowAnimation = .fade
    ) {
        var indexPaths: [IndexPath] = []
        itemsToAdd.enumerated().forEach {
            let nib = UINib(
                nibName: $0.element.reuseIdentifier,
                bundle: nil
            )
            tableView?.register(
                nib,
                forCellReuseIdentifier: $0.element.reuseIdentifier
            )
            identifierToItemsData[$0.element.identifier] = $0.element.data
            let indexPath = IndexPath(row: items.count + $0.offset, section: 0)
            indexPaths.append(indexPath)
        }

        tableView?.beginUpdates()
        items.append(contentsOf: itemsToAdd)
        tableView?.insertRows(at: indexPaths, with: animation)
        tableView?.endUpdates()
    }

    public func insertItems(
        itemsToInsert: [CellItem],
        after identifier: String,
        animation: UITableView.RowAnimation = .fade
    ) {
        guard let indexRow = items.firstIndex(where: { $0.identifier == identifier }) else {
            debugPrint("😔 Can't find item with identifier: \(identifier)")
            return
        }
        let row = indexRow + 1
        var indexPaths: [IndexPath] = []
        itemsToInsert.enumerated().forEach {
            let nib = UINib(
                nibName: $0.element.reuseIdentifier,
                bundle: nil
            )
            tableView?.register(
                nib,
                forCellReuseIdentifier: $0.element.reuseIdentifier
            )
            identifierToItemsData[$0.element.identifier] = $0.element.data
            let indexPath = IndexPath(row: row + $0.offset, section: 0)
            indexPaths.append(indexPath)
        }

        tableView?.beginUpdates()
        items.insert(contentsOf: itemsToInsert, at: row)
        tableView?.insertRows(at: indexPaths, with: animation)
        tableView?.endUpdates()
    }

    public func replace(
        pairs: [
            (String, CellItem)
        ]
    ) {
        var rows: [Int] = []
        pairs.forEach { pair in
            let identifier = pair.0
            let item = pair.1
            guard let originalItem = items.first(where: { $0.identifier == identifier }) else {
                debugPrint("TableViewAdapter: 😔 Can't replace item \(identifier), no such item!")
                return
            }
            guard let originalItemRow = items.firstIndex(where: { $0.identifier == identifier }) else {
                debugPrint("TableViewAdapter: 😔 Can't replace item \(identifier), no such item!")
                return
            }
            items.replace(originalItem, item)
            identifierToItemsData[item.identifier] = item.data
            rows.append(originalItemRow)
        }
        reloadItems(
            rows: rows
        )
    }

    public func removeItems(
        identifiers: [String],
        animation: UITableView.RowAnimation = .fade
    ) {
        let removePairs: [(IndexPath, String)] = identifiers.compactMap { identifier in
            guard let row = items.firstIndex(
                where: {
                    $0.identifier == identifier
                }
            ) else {
                return nil
            }
            return (
                IndexPath(
                    row: row, section: 0
                ),
                identifier
            )
        }
        tableView?.beginUpdates()
        removePairs.forEach {
            _ = items.safeRemoveAt($0.0.row)
            identifierToItemsData.removeValue(forKey: $0.1)
            identifierToVisibleCells.removeValue(forKey: $0.1)
        }
        let indexPaths = removePairs.compactMap { $0.0 }
        tableView?.deleteRows(
            at: indexPaths,
            with: animation
        )
        tableView?.endUpdates()
    }

    public func removeAll(
        except keepIdentifiers: [String] = [],
        animation: UITableView.RowAnimation = .fade
    ) {
        items.forEach {
            guard keepIdentifiers.contains($0.identifier) == false else { return }
            removeItems(
                identifiers: [$0.identifier],
                animation: animation
            )
        }
    }

    public func scrollTo(cell: TableViewAdapterCell?, position: UITableView.ScrollPosition = .middle, animated: Bool = true) {
        guard let cell else { return }
        guard let indexPath = tableView?.indexPath(for: cell) else { return }
        tableView?.scrollToRow(at: indexPath, at: position, animated: animated)
    }

    public func scrollTo(identifier: String?, position: UITableView.ScrollPosition = .top, animated: Bool = true) {
        guard let index = items.firstIndex(where: { item -> Bool in
            item.identifier == identifier
        }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        tableView?.scrollToRow(at: indexPath, at: position, animated: animated)
    }
}

extension TableViewAdapter: UITableViewDelegate {
    public func tableView(
        _: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard let cell = cell as? TableViewAdapterCell else { return }
        guard let item = items.at(indexPath.row) else { return }
        identifierToVisibleCells[item.identifier] = cell
    }

    public func tableView(
        _: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard let item = items.at(indexPath.row) else { return }
        guard cell == identifierToVisibleCells[item.identifier] else { return }
        identifierToVisibleCells.removeValue(forKey: item.identifier)
    }

    public func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let item = items.at(indexPath.row) else { return false }
        return item.canEdit
    }

    public func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    public func tableView(
        _: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard let item = items.at(indexPath.row) else { return }
        guard let cell = identifierToVisibleCells[item.identifier] else { return }
        switch editingStyle {
        case .delete:
            delegate?.tableViewAdapter(
                adapter: self,
                didRemoveCell: cell,
                item: item
            )
        default:
            break
        }
    }

    public func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items.at(indexPath.row)
        return item?.height ?? 2
    }

    public func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items.at(indexPath.row)
        return item?.height ?? 2
    }
}

extension TableViewAdapter: UITableViewDataSource {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        debugPrint("items.count: \(items.count)")
        return items.count
    }

    public func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = cellAt(indexPath)
        cell?.selectionStyle = .none
        cell?.cellItemData = item.data
        cell?.fill()
        cell?.fill(data: item.data)
        return cell ?? UITableViewCell()
    }

    public func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }
}

extension TableViewAdapter: TableViewAdapterCellDelegate {
    public func tableViewAdapterCellDidTap(cell: TableViewAdapterCell) {
        guard let indexPath = tableView?.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        delegate?.tableViewAdapter(
            adapter: self,
            didSelectCell: cell,
            item: item
        )
    }
}

extension TableViewAdapter: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomPoint = scrollView.contentSize.height - scrollView.frame.height
        let scrollOffset = scrollView.contentOffset.y

        if scrollOffset <= 0 {
            delegate?.tableViewAdapter(adapter: self, didReachScrollViewContentPosition: .top, offset: scrollOffset)
        }
        else if scrollOffset >= bottomPoint {
            delegate?.tableViewAdapter(adapter: self, didReachScrollViewContentPosition: .bottom, offset: scrollOffset)
        }
        else {
            delegate?.tableViewAdapter(adapter: self, didReachScrollViewContentPosition: .somewehere, offset: scrollOffset)
        }

        if lastContentOffset > scrollView.contentOffset.y {
            delegate?.tableViewAdapter(adapter: self, didScrollToDirection: .scrollToTop)
        }
        else if lastContentOffset < scrollView.contentOffset.y {
            delegate?.tableViewAdapter(adapter: self, didScrollToDirection: .scrollToBottom)
        }
    }
}
