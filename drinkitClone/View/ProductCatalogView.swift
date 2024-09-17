//
//  ProductCatalogView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 17.09.2024.
//

import SwiftUI

struct ProductCatalogView: View {
    @EnvironmentObject var productViewModel : ProductViewModelImpl
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            HeaderView(
                text: "Products",
                action: {
                    dismiss()
                },
                icon: "arrow.backward")
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(productViewModel.products) { product in
                    CatalogGridCardView(text: product.title, category: product.category, color: product.color, action: {productViewModel.addToCart(product: product)})
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProductCatalogView()
        .environmentObject(ProductViewModelImpl())
}
