//
//  StarRatingView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    let count: Int

    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= Int(self.rating) ? "star.fill" : "star")
                    .foregroundColor(Color.yellow)
            }
            Spacer()
                .frame(width: 16)
            Text("\(count)")
        }
        .padding()
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 4.0, count: 6)
            .previewLayout(.sizeThatFits)
    }
}
