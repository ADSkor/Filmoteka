//
//  CollectionViewAdapter.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

public class CollectionViewAdapter: NSObject {
    // swiftlint:disable bad_uicollectionview
    private weak var collectionView: UICollectionView?

    public weak var dataSource: CollectionViewAdapterDataSource?
    public weak var delegate: CollectionViewAdapterDelegate?

    private var registeredIdentifiers = Set<String>()

    private var refreshControl = UIRefreshControl()
    private var beginDraggingContentOffset: CGFloat?
    private var items: [CollectionViewAdapterItem<CollectionViewAdapterCell, CollectionViewAdapterItemData>] = []
    private var identifierToItemsData: [String: CollectionViewAdapterItemData] = [:]
    // swiftlint:disable:next weak_delegate
    private var manualSizingDelegate: CollectionViewAdapterManualSizingDelegate?
    private var pagerMode = false

    public func set(
        collectionView: UICollectionView?,
        autoSizing: Bool,
        pullToRefreshEnabled: Bool = false
    ) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = autoSizing ? UICollectionViewFlowLayout.automaticSize : CGSize.zero
        }
        if autoSizing == false {
            manualSizingDelegate = CollectionViewAdapterManualSizingDelegate()
            manualSizingDelegate?.dataSource = self
            manualSizingDelegate?.scrollViewDelegate = self
            collectionView?.delegate = manualSizingDelegate
        }

        if pullToRefreshEnabled {
            refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
            collectionView?.alwaysBounceVertical = true
            collectionView?.addSubview(refreshControl)
        }
    }

    public func stopPullToRefreshControl() {
        refreshControl.endRefreshing()
    }

    @objc func handlePullToRefresh() {
        delegate?.collectionViewAdapterDidPullToRefresh(adapter: self)
    }

    public func set(
        items: [CollectionViewAdapterItem<CollectionViewAdapterCell, CollectionViewAdapterItemData>]
    ) {
        self.items = items
        items.forEach {
            let nib = UINib(
                nibName: $0.reuseIdentifier,
                bundle: nil
            )
            if registeredIdentifiers.contains($0.reuseIdentifier) == false {
                collectionView?.register(
                    nib,
                    forCellWithReuseIdentifier: $0.reuseIdentifier
                )
                registeredIdentifiers.insert($0.reuseIdentifier)
            }
            identifierToItemsData[$0.identifier] = $0.data
        }
        collectionView?.reloadData()
    }

    public func scrollToTop() {
        collectionView?.contentOffset = CGPoint(x: 0, y: 0)
    }

    public func show(horizontalScrollIndicator: Bool) {
        collectionView?.showsHorizontalScrollIndicator = horizontalScrollIndicator
    }

    public func show(verticalScrollIndicator: Bool) {
        collectionView?.showsVerticalScrollIndicator = verticalScrollIndicator
    }

    public func set(bounces: Bool) {
        collectionView?.bounces = bounces
    }

    public func set(pagerMode: Bool) {
        self.pagerMode = pagerMode
        collectionView?.isPagingEnabled = pagerMode
    }

    public func set(scrollDirection: UICollectionView.ScrollDirection) {
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = scrollDirection
    }

    public func set(
        contentOffset: CGPoint,
        animated: Bool = false
    ) {
        collectionView?.setContentOffset(
            contentOffset,
            animated: animated
        )
    }

    private func cellAt(_ indexPath: IndexPath) -> CollectionViewAdapterCell? {
        let item = items[indexPath.row]
        let cellIdentifier = item.reuseIdentifier
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionViewAdapterCell
        cell?.delegate = self
        return cell
    }
}

extension CollectionViewAdapter: CollectionViewAdapterCellDelegate {
    public func collectionViewAdapterCellDidTap(_ cell: CollectionViewAdapterCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        delegate?.collectionViewAdapter(
            adapter: self,
            didSelectCell: cell,
            item: item
        )
    }
}

extension CollectionViewAdapter: UICollectionViewDataSource {
    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    public func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = cellAt(indexPath)
        cell?.fill(data: item.data)

        return cell ?? UICollectionViewCell()
    }
}

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        return dataSource?.collectionViewAdapterEdgeInsets(self) ?? UIEdgeInsets.zero
    }

    public func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInterItemSpacingForSectionAtminimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        dataSource?.collectionViewAdapterMinimumInterItemSpacing(self) ?? .zero
    }

    public func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        dataSource?.collectionViewAdapterMinimumLineSpacing(self) ?? .zero
    }
}

extension CollectionViewAdapter: CollectionViewAdapterManualSizingDelegateDataSource {
    func collectionViewAdapterManualSizingDelegateMinimumLineSpacing(_: CollectionViewAdapterManualSizingDelegate) -> CGFloat {
        return dataSource?.collectionViewAdapterMinimumLineSpacing(self) ?? 0
    }

    func collectionViewAdapterManualSizingDelegateEdgeInsets(_: CollectionViewAdapterManualSizingDelegate) -> UIEdgeInsets {
        return dataSource?.collectionViewAdapterEdgeInsets(self) ?? UIEdgeInsets.zero
    }

    func collectionViewAdapepterManualSizingDelegate(
        _: CollectionViewAdapterManualSizingDelegate,
        sizeForIndexPath indexPath: IndexPath
    ) -> CGSize {
        let item = items[indexPath.row]
        return dataSource?.collectionViewAdapter(
            self,
            sizeForItem: item
        ) ?? CGSize(
            width: 128,
            height: 128
        )
    }
}

extension CollectionViewAdapter: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginDraggingContentOffset = scrollView.contentOffset.y
    }

    public func scrollViewDidEndDecelerating(_: UIScrollView) {
        beginDraggingContentOffset = nil
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomPoint = scrollView.contentSize.height - scrollView.frame.height
        let scrollOffset = scrollView.contentOffset.y

        if scrollOffset <= 0 {
            delegate?.collectionViewAdapter(adapter: self, didReachScrollViewContentPosition: .top)
        }
        else if scrollOffset >= bottomPoint {
            delegate?.collectionViewAdapter(adapter: self, didReachScrollViewContentPosition: .bottom)
        }
        else {
            delegate?.collectionViewAdapter(adapter: self, didReachScrollViewContentPosition: .somewehere)
        }

        if let beginDraggingContentOffset = beginDraggingContentOffset {
            if beginDraggingContentOffset > scrollView.contentOffset.y {
                delegate?.collectionViewAdapter(adapter: self, didScrollToDirection: .scrollToTop)
            }
            else if beginDraggingContentOffset < scrollView.contentOffset.y {
                delegate?.collectionViewAdapter(adapter: self, didScrollToDirection: .scrollToBottom)
            }
        }

        if pagerMode {
            let centerX = scrollView.contentOffset.x + (scrollView.frame.width / 2)
            let page = Int(centerX / scrollView.frame.width)

            delegate?.collectionViewAdapter(
                adapter: self,
                didStopAtPage: page
            )
        }
    }
}
