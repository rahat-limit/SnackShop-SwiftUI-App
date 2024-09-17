//
//  HeaderView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 10.09.2024.
//

import SwiftUI

struct HeaderView: View {
    var text : String = "Order from The Best OF Snacks"
    var action : (() -> Void)? = nil
    var icon : String = "cart"
    var destination : AnyView? = nil
    var cartProductsQuantity : Int? = nil
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 30))
                .fontWeight(.semibold)
            Spacer()
            if let actionFunc = action {
                imageView
                    .onTapGesture {
                        actionFunc()
                    }
            } else if let dist = destination {
                NavigationLink(destination: dist) {
                    imageView
                }
            } else {
                imageView
            }
            
            
        }
        .padding(30)
    }
    var imageView: some View {
        
        ZStack(alignment: .bottomLeading) {
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundStyle(.black)
                .padding(20)
                .frame(width: 70, height: 90)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke()
                    .opacity(0.4)
                    .foregroundStyle(.black))
            if let quantity = cartProductsQuantity, quantity != 0 {
                Text("\(cartProductsQuantity!)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(6)
                    .foregroundStyle(.white)
                    .background(.red)
                    .clipShape(Circle())
                    .offset(x: -3, y: 5)
                
            }
        }
        
    }
    
}

#Preview {
    HeaderView()
}
