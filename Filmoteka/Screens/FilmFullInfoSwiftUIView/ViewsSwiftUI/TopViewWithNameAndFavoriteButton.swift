//
//  TopViewWithNameAndFavoriteButton.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

struct TopViewWithNameAndFavoriteButton: View {
    //Properties
    @State var appContext: AppContext
    //We must use it for change image on button
    @State var favoriteToggler: Bool = false
    let title: String
    let filmId: Int
    let dismissAction: (() -> Void)
    
    //body
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismissAction()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 24, height: 24)
                }
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 8))
                Text(title)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .font(.title)
                    .lineLimit(1...3)
                Spacer()
                //MARK: - Favorites action
                Button {
                    if let index = appContext.favoritesMovies.firstIndex(where: { $0 == filmId }) {
                        appContext.favoritesMovies.remove(at: index)
                    } else {
                        appContext.favoritesMovies.append(filmId)
                    }
                    UserDefaults.standard.set(appContext.favoritesMovies, forKey: "favoritesMovies")
                    favoriteToggler.toggle()
                } label: {
                    //Change image on button
                    if favoriteToggler || !favoriteToggler {
                        switch appContext.favoritesMovies.contains(filmId) {
                        case true :
                            Image("redHeart")
                                .frame(width: 24, height: 24)
                        case false :
                            Image("heart_empty")
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 20))
            }
            Divider()
                .background(Color(uiColor: UIColor.systemGray2))
        }
        
    }
}

struct TopViewWithNameAndFavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        TopViewWithNameAndFavoriteButton(appContext: AppContext(), title: "Best Film", filmId: 1){}
            .previewLayout(.sizeThatFits)
    }
}
