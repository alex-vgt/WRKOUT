//
//  WRKOUTApp.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

@main
struct WRKOUTApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
