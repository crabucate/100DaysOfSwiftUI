//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 09.02.21.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            FriendList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
