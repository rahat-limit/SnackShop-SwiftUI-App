//
//  ProductCardView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 09.09.2024.
//

import SwiftUI

struct ProductCardView: View {
    var product : ProductModel
    var action : (() -> Void)
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 44))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: 180, alignment: .leading)
                Text(product.category)
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.gray.opacity(0.5))
                    .clipShape(Capsule())
                Spacer()
                HStack {
                    Text("$9.0")
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: action) {
                        Image(systemName: "basket")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 25)
                            .background(.black)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                .background(.gray.opacity(0.3))
                .clipShape(Capsule())
            }
        }
        .padding(30)
        .frame(width: UIScreen.main.bounds.width - 80,
        height: 422)
        .background(product.color)
        .clipShape(.rect(cornerRadius: 42))
    }
}

#Preview {
    ProductCardView(product: ProductModel(title: "Twister Chips", price: 9.0, category: "Chips", color: .yellow), action: {})
}
