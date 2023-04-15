//
//  SearchScreenResultsItemProductCardCell.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Miji
import UIKit

class SearchScreenResultsItemProductCardCell: TableViewAdapterCell {

    @IBOutlet private weak var smallView: UIView?
    @IBOutlet private weak var mainLabel: UILabel?
    
    private var data: SearchScreenResultsItemProductCardCellData?
    
    static func item(
        identifier: String = UUID().uuidString,
        value: String,
        isClickable: Bool,
        delegate: SearchScreenResultsItemProductCardCellDelegate?
    ) -> CellItem {
        return CellItem(
            cellClass: SearchScreenResultsItemProductCardCell.self,
            data: SearchScreenResultsItemProductCardCellData(
                value: value,
                isClickable: isClickable,
                delegate: delegate
            )
        )
    }

    override func fill(data: TableViewAdapterItemData) {
        guard let data = data as? SearchScreenResultsItemProductCardCellData else { return }
        self.data = data
        mainLabel?.text = data.value
        smallView?.layer.cornerRadius = 2
        smallView?.clipsToBounds = true
        smallView?.backgroundColor = .black
        if data.isClickable {
            smallView?.isHidden = false
            mainLabel?.textColor = .systemBlue
        } else {
            smallView?.isHidden = true
            mainLabel?.textColor = .black
        }
    }
    
    @IBAction func didTap(_ sender: UIButton) {
        data?.delegate?.searchScreenResultsItemProductCardCell(self, didSelectElement: data?.value ?? "")
    }
}
