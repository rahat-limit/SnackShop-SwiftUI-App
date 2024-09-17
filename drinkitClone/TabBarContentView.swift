//
//  TabBarContentView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI

struct TabBarContentView: View {
    @EnvironmentObject var productViewMode : ProductViewModelImpl
    @EnvironmentObject var appLoadingManager : AppLoadingManager
    
    @State var selectedTab : String = "house.fill"
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)){
                    TabView(selection: $selectedTab,
                            content:  {
                        HomeView().tag("house.fill")
                        AccountView().tag("person")
                    })
                    
                }
                .overlay(alignment: .bottom) {
                    CustomBottomNavigationBar(selectedTab: $selectedTab)
                }
                if appLoadingManager.loading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    VStack {
                        ProgressView("Loading...") // Прогресс-бар
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    TabBarContentView()
        .environmentObject(ProductViewModelImpl())
        .environmentObject(AuthViewModelImpl(firestoreManager: FirestoreManagerImpl(), errorManager: ErrorManager(), appLoadingManager: AppLoadingManager.shared))
}
