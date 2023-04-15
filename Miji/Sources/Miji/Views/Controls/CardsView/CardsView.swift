//
//  File.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import UIKit

public class CardsView: XibView {
    // swiftlint:disable bad_uicollectionview
    @IBOutlet private weak var collectionView: UICollectionView?

    private let collectionViewAdapter = CollectionViewAdapter()

    override public func module() -> Bool {
        return true
    }

    private var cardWidth: CGFloat = .zero
    private var cardHeight: CGFloat = .zero
    private var edgeInsets: UIEdgeInsets = .zero
    private var spacing: CGFloat = 0

    override public func awakeFromNib() {
        super.awakeFromNib()
        collectionViewAdapter.set(
            collectionView: collectionView,
            autoSizing: false
        )
    }

    public func set(
        items: [CollectionCellItem],
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        bounces: Bool = true,
        scrollerVisible _: Bool = false,
        edgeInsets: UIEdgeInsets = .zero,
        spacing: CGFloat = 0,
        delegate: CollectionViewAdapterDelegate? = nil
    ) {
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self.edgeInsets = edgeInsets
        self.spacing = spacing

        collectionViewAdapter.delegate = delegate
        collectionViewAdapter.dataSource = self
        collectionViewAdapter.set(bounces: bounces)
        collectionViewAdapter.set(pagerMode: false)
        collectionViewAdapter.set(items: items)
    }
}

extension CardsView: CollectionViewAdapterDataSource {
    public func collectionViewAdapter(
        _: CollectionViewAdapter,
        sizeForItem _: CollectionViewAdapterItem<
            CollectionViewAdapterCell,
            CollectionViewAdapterItemData
        >
    ) -> CGSize {
        return CGSize(
            width: cardWidth,
            height: cardHeight
        )
    }

    public func collectionViewAdapterEdgeInsets(
        _: CollectionViewAdapter
    ) -> UIEdgeInsets {
        edgeInsets
    }

    public func collectionViewAdapterMinimumLineSpacing(_: CollectionViewAdapter) -> CGFloat {
        return spacing
    }
}
