//
//  ContentView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 09.09.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("View")
    }
    
}
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
