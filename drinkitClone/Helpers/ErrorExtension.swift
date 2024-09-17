//
//  ErrorExtension.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 16.09.2024.
//
import SwiftUI
import Foundation

// Wrapper to make String conform to Identifiable
struct ErrorWrapper: Identifiable {
    let id = UUID() // Unique identifier
    let message: String
}

extension View {
    func trackError(using errorManager: ErrorManager) -> some View {
        self.modifier(ErrorSnackbarModifier(errorManager: errorManager))
    }
}

struct ErrorSnackbarModifier: ViewModifier {
    @ObservedObject var errorManager: ErrorManager

    func body(content: Content) -> some View {
        ZStack {
            content
            if errorManager.showSnackbar {
                CustomSnackbarView(message: errorManager.currentError?.message ?? "", isVisible: $errorManager.showSnackbar)
            }
        }
    }
}
