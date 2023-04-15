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

public class AutosizingCardsView: XibView {
    // swiftlint:disable bad_uicollectionview
    @IBOutlet private weak var collectionView: UICollectionView?

    private let collectionViewAdapter = CollectionViewAdapter()

    override public func module() -> Bool {
        return true
    }

    private var edgeInsets: UIEdgeInsets = .zero
    private var spacing: CGFloat = 0

    public func set(
        items: [CollectionCellItem],
        bounces: Bool = true,
        scrollerVisible: Bool = false,
        edgeInsets: UIEdgeInsets = .zero,
        spacing: CGFloat = 0,
        delegate: CollectionViewAdapterDelegate? = nil
    ) {
        self.edgeInsets = edgeInsets
        self.spacing = spacing

        collectionViewAdapter.set(
            collectionView: collectionView,
            autoSizing: true
        )

        collectionViewAdapter.delegate = delegate
        collectionViewAdapter.dataSource = self
        collectionViewAdapter.show(verticalScrollIndicator: scrollerVisible)
        collectionViewAdapter.show(horizontalScrollIndicator: scrollerVisible)
        collectionViewAdapter.set(bounces: bounces)
        collectionViewAdapter.set(pagerMode: false)
        collectionViewAdapter.set(items: items)
    }
}

extension AutosizingCardsView: CollectionViewAdapterDataSource {
    public func collectionViewAdapterEdgeInsets(
        _: CollectionViewAdapter
    ) -> UIEdgeInsets {
        edgeInsets
    }

    public func collectionViewAdapterMinimumLineSpacing(_: CollectionViewAdapter) -> CGFloat {
        return spacing
    }
}
