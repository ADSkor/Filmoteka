//
//  Context.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Foundation
import Miji

class Context: ObservableObject {
    lazy var api: API = SemiAPI(context: self)

    private let bag = Bag()
    
    init() {}

    func initialize() {
        debugPrint("We can init here anything what must be initiated in context...")
//        TODO: Load History if needed
    }
}
