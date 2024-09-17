//
//  CustomBottomNavigationBar.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 17.09.2024.
//

import SwiftUI

struct CustomBottomNavigationBar: View {
    @Binding var selectedTab : String
    var body: some View {
        HStack() {
            Spacer()
            TabBarButton(selectedItem: $selectedTab)
            Spacer()
            TabBarButton(image: "person", selectedItem: $selectedTab)
            Spacer()
        }
        
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background(.white)
        .clipShape(Capsule())
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

#Preview {
    CustomBottomNavigationBar(selectedTab: .constant(""))
}
