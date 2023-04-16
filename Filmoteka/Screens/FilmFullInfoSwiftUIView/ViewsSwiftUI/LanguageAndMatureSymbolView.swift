//
//  LanguageAndMatureSymbolView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

struct LanguageAndMatureSymbolView: View {
    var original_language: String
    var adult: Bool
    var body: some View {
        HStack {
            Text("Original language:")
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 8))
                .font(.subheadline)
            Text(original_language)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 80))
                .font(.subheadline)
            //Seems right now it's broken on TMDB side. Every movie is not for adult right now
            if adult {
                Image(systemName: "18.circle")
                    .resizable()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red)
            }
        }
    }
}

struct LanguageAndMatureSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageAndMatureSymbolView(original_language: "En", adult: true)
            .previewLayout(.sizeThatFits)
    }
}
