//
//  AppStatusManager.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 17.09.2024.
//

import SwiftUI

@MainActor
class AppLoadingManager: ObservableObject {
    @Published private(set) var loading = false
    static var shared = AppLoadingManager()
    
    func startLoading() {
        loading = true
    }
    
    func stopLoading() {
        loading = false
    }
}
