//
//  PagesViewDelegate.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

public protocol PagesViewDelegate: AnyObject {
    func pagesView(_ view: PagesView, didStopAtPage page: Int)
    func pagesView(_ view: PagesView, didTapAt item: CollectionCellItem)
}

public extension PagesViewDelegate {
    func pagesView(_: PagesView, didStopAtPage _: Int) {}
    func pagesView(_: PagesView, didTapAt _: CollectionCellItem) {}
}
