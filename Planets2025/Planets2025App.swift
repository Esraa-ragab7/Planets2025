//
//  Planets2025App.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI

@main
struct Planets2025App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
