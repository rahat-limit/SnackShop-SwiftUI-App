//
//  AuthHeadlineView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct AuthHeadlineView: View {
    var title : String = "Sign In"
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    AuthHeadlineView()
}
