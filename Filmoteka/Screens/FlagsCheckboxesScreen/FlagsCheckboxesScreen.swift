//
//  FlagsCheckboxesScreen.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 17.04.2023.
//

import Miji
import SwiftUI

struct FlagsCheckboxesScreen: View {
    @ObservedObject var viewModel = FlagsCheckboxesScreenViewModel()

    static func viewController() -> UIViewController {
        let screen = FlagsCheckboxesScreen()
        return UIHostingController(rootView: screen)
    }

    var body: some View {
        List {
            ForEach($viewModel.flags) { $flag in
                Toggle(flag.name, isOn: $flag.active).padding()
            }
        }
    }
}

class FlagsCheckboxesScreenViewModel: ObservableObject {
    @Published var flags: [FlagsCheckboxesItem]

    init() {
        flags = []
        SemiAPIFlags.allCases.enumerated().forEach {
            flags.append(
                FlagsCheckboxesItem(
                    id: $0.0,
                    name: $0.1.rawValue,
                    active: UserDefaults.standard.bool(forKey: $0.1.rawValue)
                )
            )
        }
    }
}

struct FlagsCheckboxesItem: Identifiable {
    let id: Int
    let name: String
    var active: Bool {
        didSet {
            UserDefaults.standard.set(active, forKey: name)
        }
    }
}
