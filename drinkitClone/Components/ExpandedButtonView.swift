//
//  ExpandedButtonView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI

struct ExpandedButtonView: View {
    var text : String = "Sign Out"
    @State var isDisabled : Bool = false
    var action : (() -> Void) = {}
    var body: some View {
        Button(action: {
//            isDisabled = true
            action()
        }) {
            Text(text)
                .foregroundStyle(.black)
                .font(.title2)
                .fontWeight(.medium)
                .frame(width: UIScreen.main.bounds.width - 50, height: 45)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundStyle(.black))
                
        }
//        .disabled(isDisabled)
    }
}

#Preview {
    ExpandedButtonView()
}
