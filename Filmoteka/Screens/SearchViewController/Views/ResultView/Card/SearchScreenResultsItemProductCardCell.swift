//
//  SearchScreenResultsItemProductCardCell.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Miji
import UIKit
import SDWebImage

class SearchScreenResultsItemProductCardCell: TableViewAdapterCell {

    @IBOutlet private weak var isFavoriteButton: UIButton?
    @IBOutlet private weak var mainImageView: UIImageView?
    @IBOutlet private weak var mainLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    
    private var data: SearchScreenResultsItemProductCardCellData?
    
    static func item(
        identifier: String = UUID().uuidString,
        isFavorite: Bool,
        film: Film,
        delegate: SearchScreenResultsItemProductCardCellDelegate?
    ) -> CellItem {
        return CellItem(
            cellClass: SearchScreenResultsItemProductCardCell.self,
            data: SearchScreenResultsItemProductCardCellData(
                isFavorite: isFavorite,
                film: film,
                delegate: delegate
            )
        )
    }

    override func fill(data: TableViewAdapterItemData) {
        guard let data = data as? SearchScreenResultsItemProductCardCellData else { return }
        self.data = data
        isFavoriteButton?.setImage(data.isFavorite ? UIImage(named: "redHeart") : UIImage(named: "heart_empty"), for: .normal)
        mainLabel?.text = data.film.title
        dateLabel?.text = data.film.release_date
        mainImageView?.layer.cornerRadius = 2
        mainImageView?.clipsToBounds = true
        mainImageView?.sd_setImage(
            with: URL(string: "https://image.tmdb.org/t/p/w300\(data.film.poster_path)"),
            placeholderImage: UIImage(named: "empty_image")
        )
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        guard let data else { return }
        UIView.animate(withDuration: 0.15) {
            self.isFavoriteButton?.flash()
            self.layoutIfNeeded()
        }
        main(delay: 0.15) {
            self.data?.delegate?.searchScreenResultsItemProductCardCell(self, didTapFavorite: data.film)
        }
    }
    
    @IBAction func didTap(_ sender: UIButton) {
        guard let data else { return }
        data.delegate?.searchScreenResultsItemProductCardCell(self, didSelect: data.film)
    }
}
