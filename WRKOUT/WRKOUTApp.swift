//
//  WRKOUTApp.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI
import SwiftData

@main
struct WRKOUTApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Workout.self)
        } catch {
            fatalError("Could not create model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(modelContainer)
    }
}
