//
//  FilmFullInfoView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

struct FilmFullInfoView: View {
    
    @State var film: Film
    @State var appContext: AppContext
    var dismissAction: (() -> Void)
    
    var body: some View {
        VStack {
            TopViewWithNameAndFavoriteButton(appContext: appContext, title: film.title, filmId: film.id) {
                dismissAction()
            }
            ScrollView {
                FilmImageFromWebView(poster_path: film.poster_path)
                StarRatingView(rating: film.vote_average, count: film.vote_count)
                LanguageAndMatureSymbolView(original_language: film.original_language, adult: film.adult)
                
                if film.original_title.count > 0 {
                    TitleAndTextOfElement(title: "Original title", text: film.original_title)
                }
                if film.overview.count > 0 {
                    TitleAndTextOfElement(title: "Overview", text: film.overview)
                }
                TitleAndTextOfElement(title: "Release date", text: film.release_date)
                
            }
        }
    }
    
    
}

struct FilmFullInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmFullInfoView(film: Film(json: ""), appContext: AppContext(), dismissAction: {})
    }
}
