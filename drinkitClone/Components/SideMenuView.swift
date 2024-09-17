//
//  SideMenuView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}


#Preview {
    SideMenuView(isShowing: .constant(true), content: AnyView(
        VStack {
            Text("dw")
        }
            .frame(width: 300, height: .infinity)
            .background(.red)
    ))
        
}
