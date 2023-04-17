//
//  SearchScreenResultsView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Miji
import UIKit

class SearchScreenResultsView: XibView {
    weak var delegate: SearchScreenResultsViewDelegate?

    @IBOutlet private weak var tableView: UITableView?
    private let tableViewAdapter = TableViewAdapter()
    
    func set(
        films: [Film]?,
        resultsViewDelegate: SearchScreenResultsViewDelegate,
        appContext: AppContext?
    ) {
        self.delegate = resultsViewDelegate
        
        let items = SearchScreenResultsViewItemsFactory.items(
            films: films,
            resultsView: self,
            appContext: appContext
        )
        
        tableViewAdapter.tableView = tableView
        tableViewAdapter.delegate = self

        tableViewAdapter.set(items: items)
    }
    
    func scrollToTop() {
        tableViewAdapter.scrollToTop()
    }
}

extension SearchScreenResultsView: TableViewAdapterDelegate {
    func tableViewAdapter(adapter _: TableViewAdapter, didSelectCell _: TableViewAdapterCell, item _: CellItem) {
        debugPrint("We can send information from any cell and use any data through delegation. SOLI[D] - Dependency inversion 'in the flesh'")
    }
    
    func tableViewAdapter(adapter: TableViewAdapter, didReachScrollViewContentPosition position: ScrollViewContentPosition, offset: CGFloat) {
        if position == .bottom {
            delegate?.searchScreenResultsViewDidReachBottom(self)
        }
    }
}

extension SearchScreenResultsView: SearchScreenResultsItemProductCardCellDelegate {
    func searchScreenResultsItemProductCardCell(_ cell: SearchScreenResultsItemProductCardCell, didSelect film: Film) {
        delegate?.searchScreenResultsViewDidTap(self, film: film)
    }
    
    func searchScreenResultsItemProductCardCell(_ cell: SearchScreenResultsItemProductCardCell, didTapFavorite film: Film) {
        delegate?.searchScreenResultsViewDidTap(self, didPressFavorite: film)
    }
}
