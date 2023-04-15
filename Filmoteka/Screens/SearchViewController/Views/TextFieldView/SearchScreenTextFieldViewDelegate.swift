//
//  SearchScreenTextFieldViewDelegate.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation

protocol SearchScreenTextFieldViewDelegate: AnyObject {
    func searchScreenTextFieldViewDidBeginEditing(_ view: SearchScreenTextFieldView)
    func searchScreenTextFieldViewDidTapSearchButton(_ view: SearchScreenTextFieldView, text: String)
    func searchScreenTextFieldViewTextDidChange(_ view: SearchScreenTextFieldView, text: String)
}
