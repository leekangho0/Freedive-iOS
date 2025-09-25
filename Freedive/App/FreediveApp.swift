//
//  FreediveApp.swift
//  Freedive
//
//  Created by Kanghos on 9/23/25.
//

import SwiftUI

@main
struct FreediveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
