//
//  FilmFullInfoView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

struct FilmFullInfoView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode> // for .dismiss()
    @State var film: Film
    @State var appContext: AppContext
    
    var body: some View {
        VStack {
            TopViewWithNameAndFavoriteButton(appContext: appContext, title: film.title, filmId: film.id) {
                dismiss()
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
    
    static func viewController(film: Film, mainAppContext: AppContext) -> UIViewController {
        let filmFullInfoView = FilmFullInfoView(film: film, appContext: mainAppContext)
        let filmFullInfoViewVC = UIHostingController(rootView: filmFullInfoView)
        return filmFullInfoViewVC
    }
    
    private func dismiss() {
        mode.wrappedValue.dismiss()
    }
}

struct FilmFullInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmFullInfoView(film: Film(json: ""), appContext: AppContext())
    }
}
