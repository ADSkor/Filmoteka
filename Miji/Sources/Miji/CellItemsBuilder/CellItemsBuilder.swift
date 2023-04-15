//
//  CellItemsBuilder.swift
//  For Any App
//
//  Created by Aleksandr Skorotkin on 01.11.2022.
//  Main Idea of Miji package is taken from Ilia Prokhorov
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation

@resultBuilder
public enum CellItemsBuilder {
    public static func buildEither(first: [CellItem]) -> [CellItem] {
        return first
    }

    public static func buildEither(second: [CellItem]) -> [CellItem] {
        return second
    }

    public static func buildOptional(_ component: [CellItem]?) -> [CellItem] {
        return component ?? []
    }

    public static func buildBlock(_ component: [CellItem]...) -> [CellItem] {
        return component.flatMap { $0 }
    }

    public static func buildExpression(_ component: CellItem) -> [CellItem] {
        return [component]
    }

    public static func buildArray(_ component: [[CellItem]]) -> [CellItem] {
        return component.flatMap { $0 }
    }
}

public func CellItems(@CellItemsBuilder _ cellItems: () -> [CellItem]) -> [CellItem] {
    cellItems()
}
