//
//  AppContext.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

//app context
class AppContext: ObservableObject {
    lazy var api: API = SemiAPI(appContext: self)
    
    var favoritesMovies: [Int] = []
            //TODO: FInd correct place for it
//            if let index = favoritesList.firstIndex(where: { $0 == 3 }) {
//                favoritesList.remove(at: index)
//            }
//            UserDefaults.standard.set(favoritesList, forKey: "myArray")
    
    init() {}

    func initialize() {
        debugPrint("We can init here anything what must be initiated in app context...")
        favoritesMovies = UserDefaults.standard.array(forKey: "favoritesMovies") as? [Int] ?? []
    }
}
