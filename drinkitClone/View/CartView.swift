//
//  CartView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 10.09.2024.
//

import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var productViewModel : ProductViewModelImpl
    
    var body: some View {
        ScrollView {
            HeaderView(text: "Cart", action: {
                dismiss()
            }, icon: "arrow.backward")
            if (productViewModel.cart.isEmpty) {
                Text("No Products")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                    .padding(.top, 100)
            } else {
                ForEach(productViewModel.cart) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.system(size: 23))
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .padding(.bottom, 3)
                            Text(product.category)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        Spacer()
                        Text("\(String(format: "%.2f", product.price))$")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(25)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke())
                            .foregroundStyle(.white)
                    }.padding(20)
                        .background(product.color)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                .padding(.horizontal,20)
                .padding(.bottom, 10)
            }
        }
        
        Spacer()
        Button(action: {
            productViewModel.buyProductsFromCart()
            dismiss()
        })
        {
            Text("Purchase")
                .padding(30)
                .foregroundStyle(.black)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke())
                .foregroundStyle(.black)
        }
        
    }
    
    
    
}

#Preview {
    CartView()
        .environmentObject(ProductViewModelImpl())
}
