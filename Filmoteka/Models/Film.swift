//
//  Film.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import SwiftyJSON

struct Film {
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let release_date: String
    let poster_path: String
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
    let original_language: String
    let genre_ids: [Int] //Didn't get what it is
    let backdrop_path: String // Some kind of image but not a poster
    let adult: Bool
    let video: Bool //Didn't get what it is
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        original_title = json["original_title"].stringValue
        overview = json["overview"].stringValue
        release_date = json["release_date"].stringValue
        poster_path = json["poster_path"].stringValue
        popularity = json["popularity"].doubleValue
        vote_average = json["vote_average"].doubleValue
        vote_count = json["vote_count"].intValue
        original_language = json["original_language"].stringValue
        genre_ids = json["genre_ids"].arrayObject as? [Int] ?? []
        backdrop_path = json["backdrop_path"].stringValue
        adult = json["adult"].boolValue
        video = json["adult"].boolValue
    }
}
