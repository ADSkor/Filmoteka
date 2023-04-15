//
//  RequestDataSource.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation

protocol RequestDataSource: AnyObject {
    func requestServerAddress(_ request: Any) -> String
}
