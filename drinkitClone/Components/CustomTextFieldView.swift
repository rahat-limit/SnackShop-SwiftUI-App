//
//  CustomTextFieldView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool // For secure input like password fields
    var borderColor: Color = .gray // Default border color
    var borderWidth: CGFloat = 1 // Default border width
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(15)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .padding(15)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }
        }// Optional padding around the field
        .padding(.bottom, 10)
    }
}
