//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Rick Konstan on 19/3/2024.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
