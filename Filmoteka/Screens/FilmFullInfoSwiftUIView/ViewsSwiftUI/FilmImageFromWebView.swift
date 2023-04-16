//
//  ScrollViewWithAdditionalInformation.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI

//Loading from web with SDWebImage
struct FilmImageFromWebView: View {
    let poster_path: String
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w300\(poster_path)") )
                .placeholder(Image("empty_image"))
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.size.width, height: 500, alignment: .center)
        }
    }
}

struct FilmImageFromWebView_Previews: PreviewProvider {
    static var previews: some View {
        FilmImageFromWebView(poster_path: "/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg")
            .previewLayout(.sizeThatFits)
    }
}
