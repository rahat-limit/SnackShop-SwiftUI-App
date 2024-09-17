//
//  AuthLinkButtonView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct AuthLinkButtonView: View {
    var text : String = "Sign Up"
    var action : () -> Void = {}
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Button(action: {
                    action()
                }) {
                    Text(text)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        
                        
                    Image(systemName: "arrow.right")
                        .imageScale(.small)
                }
                }.foregroundStyle(.link)
            
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

#Preview {
    AuthLinkButtonView()
}
