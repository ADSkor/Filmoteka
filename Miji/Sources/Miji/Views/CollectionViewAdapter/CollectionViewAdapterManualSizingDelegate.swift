//
//  CollectionViewAdapterManualSizingDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

class CollectionViewAdapterManualSizingDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    weak var scrollViewDelegate: UIScrollViewDelegate?
    weak var dataSource: CollectionViewAdapterManualSizingDelegateDataSource?

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource?.collectionViewAdapepterManualSizingDelegate(self, sizeForIndexPath: indexPath) ?? CGSize(width: 128, height: 128)
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return dataSource?.collectionViewAdapterManualSizingDelegateEdgeInsets(self) ?? UIEdgeInsets.zero
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return dataSource?.collectionViewAdapterManualSizingDelegateMinimumLineSpacing(self) ?? 0
    }
}

extension CollectionViewAdapterManualSizingDelegate: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}
