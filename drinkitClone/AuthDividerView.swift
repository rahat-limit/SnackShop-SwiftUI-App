//
//  AuthDividerView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct AuthDividerView: View {
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @EnvironmentObject var errorManager : ErrorManager
    
    
    var body: some View {
        if authViewModel.getAuthenticatedUser() != nil {
            TabBarContentView()
                .trackError(using: errorManager)
                
        } else {
            SignInView()
                .trackError(using: errorManager)
        }
    }
}

#Preview {
    AuthDividerView()
        .environmentObject(AuthViewModelImpl(firestoreManager: FirestoreManagerImpl(), errorManager: ErrorManager.shared, appLoadingManager: AppLoadingManager.shared))
        .environmentObject(ErrorManager.shared)
}
