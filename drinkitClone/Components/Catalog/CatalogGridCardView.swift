//
//  CatalogGridCardView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 17.09.2024.
//

import SwiftUI

struct CatalogGridCardView: View {
    var text : String
    var category : String
    var color : Color
    var action : () -> Void = {}
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.system(size: 21))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
            Text(category)
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal)
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "cart")
                        .imageScale(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(.black.opacity(0.4))
                        .cornerRadius(15)
                    
                }
            }
            .padding()
            
        }
        .frame(minWidth: UIScreen.main.bounds.width / 3,minHeight: 150, alignment: .leading)
        .padding(10)
        .background(color)
        .cornerRadius(20)
    }
}

#Preview {
    CatalogGridCardView(text: "Text", category: "Category", color: .red)
}
