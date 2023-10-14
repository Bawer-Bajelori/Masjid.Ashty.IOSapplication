//
//  MasjidApp.swift
//  Masjid
//
//  Created by Bawer Bajelori on 1/12/23.
//

import SwiftUI

@main
struct MasjidApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
