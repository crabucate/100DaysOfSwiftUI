//
//  CoreData_ProjectApp.swift
//  CoreData Project
//
//  Created by Felix Leitenberger on 06.02.21.
//

import SwiftUI

@main
struct CoreData_ProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
