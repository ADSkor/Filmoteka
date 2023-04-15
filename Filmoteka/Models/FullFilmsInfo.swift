//
//  FullFilmsInfo.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import SwiftyJSON

struct FullFilmsInfo {
    let page: Int
    let results: [Film]
    let total_pages: Int
    let total_results: Int
    
    init(
        page: Int,
        results: [Film],
        total_pages: Int,
        total_results: Int
    ) {
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
    
    init(json: JSON) {
        page = json["page"].intValue
        total_pages = json["total_pages"].intValue
        total_results = json["total_results"].intValue
        var filmsArray: [Film] = []
        json["results"].arrayValue.forEach { jsonFilm in
            filmsArray.append(Film(json: jsonFilm))
        }
        results = filmsArray
    }
}
