//
//  SearchScreenNoResultsViewExample.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import UIKit
import Miji

//Text cell with button
class SearchScreenNoResultsViewExample: TableViewAdapterCell {
    @IBOutlet private weak var mainLabel: UILabel?

    private var data: SearchScreenNoResultsViewExampleData?

    static func item(
        identifier: String = UUID().uuidString,
        example: String,
        delegate: SearchScreenNoResultsViewExampleDelegate?
    ) -> CellItem {
        return CellItem(
            identifier: identifier,
            cellClass: SearchScreenNoResultsViewExample.self,
            data: SearchScreenNoResultsViewExampleData(
                example: example,
                delegate: delegate
            )
        )
    }

    override func fill(data: TableViewAdapterItemData) {
        guard let data = data as? SearchScreenNoResultsViewExampleData else { return }
        self.data = data

        mainLabel?.text = data.example
    }

    @IBAction func buttonPressed(_: UIButton) {
        guard let data else { return }
        data.delegate?.searchScreenNoResultsViewExampleDidPressed(self, example: data.example)
    }
}
