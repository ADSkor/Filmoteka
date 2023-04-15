//
//  CollectionViewAdapterManualSizingDelegateDataSource.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import UIKit

protocol CollectionViewAdapterManualSizingDelegateDataSource: AnyObject {
    func collectionViewAdapepterManualSizingDelegate(_ delegate: CollectionViewAdapterManualSizingDelegate, sizeForIndexPath indexPath: IndexPath) -> CGSize

    func collectionViewAdapterManualSizingDelegateEdgeInsets(_ delegate: CollectionViewAdapterManualSizingDelegate) -> UIEdgeInsets

    func collectionViewAdapterManualSizingDelegateMinimumLineSpacing(_ delegate: CollectionViewAdapterManualSizingDelegate) -> CGFloat
}
