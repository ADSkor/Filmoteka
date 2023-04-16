//
//  TitleAndTextOfElement.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 16.04.2023.
//

import SwiftUI

//All Elements from bottom part of screen
struct TitleAndTextOfElement: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack {
            Text("\(title):")
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 8, trailing: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title2)
            .underline()
            Text(text)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 8, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
            
        }
    }
}

struct TitleAndTextOfElement_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndTextOfElement(title: "Overview", text: "Good film")
    }
}
