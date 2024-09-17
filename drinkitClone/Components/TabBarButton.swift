//
//  TabBarButton.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI

struct TabBarButton: View {
    var image: String = "house.fill"
    @Binding var selectedItem: String
    var body: some View {
        Button(action: {
            selectedItem = image
        }) {
            Image(systemName: image)
                .renderingMode(.template)
                .imageScale(.large)
                .foregroundStyle(selectedItem == image ? .blue : .black)
                .padding(4)
        }
    }
}
