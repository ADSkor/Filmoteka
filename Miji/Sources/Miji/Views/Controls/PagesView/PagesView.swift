//
//  PagesView.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import SwiftUI
import UIKit

public final class PagesView: XibView {
    // swiftlint:disable bad_uicollectionview
    @IBOutlet private weak var collectionView: UICollectionView?

    private weak var delegate: PagesViewDelegate?

    private let collectionViewAdapter = CollectionViewAdapter()

    private var width: CGFloat = 0
    private var height: CGFloat = 0

    private var currentPage = 0

    override public func module() -> Bool {
        return true
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        collectionViewAdapter.set(
            collectionView: collectionView,
            autoSizing: false
        )
        collectionViewAdapter.dataSource = self
        collectionViewAdapter.delegate = self
    }

    public func set(
        items: [CollectionCellItem],
        width: CGFloat,
        height: CGFloat,
        bounces: Bool = true,
        scrollerVisible: Bool = true,
        delegate: PagesViewDelegate? = nil
    ) {
        self.width = width
        self.height = height
        self.delegate = delegate

        collectionViewAdapter.set(scrollDirection: .horizontal)
        collectionViewAdapter.show(verticalScrollIndicator: scrollerVisible)
        collectionViewAdapter.show(horizontalScrollIndicator: scrollerVisible)
        collectionViewAdapter.set(bounces: bounces)
        collectionViewAdapter.set(pagerMode: true)
        collectionViewAdapter.set(items: items)
    }

    public func show(page: Int) {
        let contentOffset = CGPoint(
            x: width * CGFloat(page),
            y: 0
        )
        collectionViewAdapter.set(
            contentOffset: contentOffset
        )
    }
}

extension PagesView: CollectionViewAdapterDataSource {
    public func collectionViewAdapter(
        _: CollectionViewAdapter,
        sizeForItem _: CollectionViewAdapterItem<
            CollectionViewAdapterCell,
            CollectionViewAdapterItemData
        >
    ) -> CGSize {
        return CGSize(
            width: width,
            height: height
        )
    }
}

extension PagesView: CollectionViewAdapterDelegate {
    public func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didSelectCell _: CollectionViewAdapterCell,
        item: CollectionCellItem
    ) {
        delegate?.pagesView(self, didTapAt: item)
    }

    public func collectionViewAdapter(
        adapter _: CollectionViewAdapter,
        didStopAtPage page: Int
    ) {
        if currentPage != page {
            currentPage = page
            delegate?.pagesView(self, didStopAtPage: currentPage)
        }
    }
}
