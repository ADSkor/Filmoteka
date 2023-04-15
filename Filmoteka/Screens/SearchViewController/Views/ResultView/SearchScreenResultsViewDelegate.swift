//
//  SearchScreenResultsViewDelegate.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//  Copyright © 2022 ADSkor. All rights reserved.
//

import Foundation
import Miji

protocol SearchScreenResultsViewDelegate: AnyObject {
    func searchScreenResultsViewDidTap(_ view: SearchScreenResultsView, film: Film)
    func searchScreenResultsViewDidTap(_ view: SearchScreenResultsView, didPressFavorite: Film)
    func searchScreenResultsViewDidReachBottom(_ view: SearchScreenResultsView)
}
